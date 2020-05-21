require 'spec_helper'

describe 'mysql_server' do

  let(:default_params) do
    {
      :cluster_name           => 'test',
      :backup_share           => 'foo',
      :backup_encryption_key  => '123456789012345678901234567890123',
    }
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do

        let(:facts) do
          facts.merge({
            :hostname => 'testhost',
            :ipaddress => '157.193.40.1',
            :mysql_version => '5.7.17'
          })
        end

        context "mysql_server::backup class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server::backup') }

          it { is_expected.to contain_package('qpress')
            .with({
                'ensure' => 'installed',
            })
          }

          it { is_expected.to contain_file('/usr/local/sbin/mysql_create_backup').with({
              'ensure'  => 'file',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0700',
            })
          }

          it { is_expected.to contain_cron('mysql-backup-job-testhost').with({
              'ensure'  => 'absent',
            })
          }

        end

        context "mysql_server::backup class with default parameters" do
          let(:params) do
            default_params
          end

          it { is_expected.to contain_nshares__mount('/srv/foo').with({
              'sharename'      => 'foo',
              'client_options' => 'defaults,tcp,vers=3,ro',
              'subdir'         => 'test',
            })
          }

          it { is_expected.to contain_service('rpcbind') }

          it { is_expected.to contain_exec('create-backup-encryption-key').with({
              'command' => '/bin/echo -n 123456789012345678901234567890123 > /root/.mysql_backup_key',
              'creates' => '/root/.mysql_backup_key',
            })
          }

          it { is_expected.to contain_file('/root/.mysql_backup_key').with({
              'ensure'  => 'file',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0400',
            })
          }
        end

        context "mysql_server::backup class with backup_slave = true" do
          let(:params) do
            default_params.merge({ :backup_slave => true })
          end


          it { is_expected.to contain_cron('mysql-backup-job-testhost').with({
              'ensure'  => 'present',
              'command' => '/usr/local/bin/cronic /usr/local/sbin/mysql_create_backup',
              'user'    => 'root',
              'hour'    => '5',
            })
          }

          it { is_expected.to contain_logrotate__rule('mysql-backup-log')
            .with({
              'path'         => '/var/log/mysql/backup.log',
              'rotate'       => 105, # 15 weeks * 7 days
              'rotate_every' => 'day',
              'compress'     => true,
            })
          }

        end

      end
    end
  end

end
