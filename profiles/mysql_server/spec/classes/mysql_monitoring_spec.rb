require 'spec_helper'

describe 'mysql_server::monitoring' do

  let(:default_params) do
    {
      :collectd_username  => 'collectd',
      :collectd_password  => 'dtcelloc',
    }
  end

  let :pre_condition do
    [
      'class{ "collectd" :;}',
      'class{ "nrpe" :;}',
      'class{ "mysql::server":;}',
    ]
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            {
              :hostname => 'testhost',
              :ipaddress => '157.193.40.1',
              :mountpoints => { '/' => {'available' => "16.58 GiB", } , '/var' => { 'available' => "16.58 GiB",} ,},
              :sudoversion => '2.0',
              :mysql_version => '5.7.17'
            }
          )
        end

       context "mysql_server::monitoring class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server::monitoring') }

        end

        let(:params) do
          default_params
        end

        context "mysql_server::monitoring class with default parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server::monitoring') }

          it { is_expected.to contain_package('python-mysqldb')
            .with({
                'ensure' => 'installed',
            })
          }

          it { is_expected.to contain_mysql_user('collectd@127.0.0.1')
            .with({
              'ensure' => 'present',
              'password_hash' => '*9981F8A63D0156E90561D7C9859F72F01C012767',
            })
          }

          it { is_expected.to contain_mysql_grant('collectd@127.0.0.1/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['PROCESS', 'REPLICATION CLIENT'],
              'table'      => '*.*',
              'user'       => 'collectd@127.0.0.1',
            })
          }

          it { is_expected.to contain_class('collectd::plugin::python')
            .with({
              'modules' => {
                'mysql' => {
                  'script_source' => 'puppet:///modules/mysql_server/collectd-mysql.py',
                  'config'        => [{
                    'Host'     => '127.0.0.1',
                    'Port'     => '3306',
                    'User'     => 'collectd',
                    'Password' => 'dtcelloc',
                    'Verbose'  => false,
                  },]
                }
              }
            })
          }

          it { is_expected.to contain_collectd__plugin__python__module('mysql') }

          it { is_expected.to contain_file('/etc/nagios/mysql.conf')
            .with({
              'ensure'  => 'file',
              'owner'   => 'root',
              'owner'   => 'root',
              'mode'    => '0644',
              'content' => 'user = nagios
password = soigan
host = 127.0.0.1
'
            })
          }

          it { is_expected.to contain_file('check_mysql_slave')
            .with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
              'source' => 'puppet:///modules/mysql_server/check_mysql_slave',
            })
          }

          it { is_expected.to contain_file('check_mysql_config')
            .with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
              'source' => 'puppet:///modules/mysql_server/check_mysql_config.bash',
            })
          }

          it { is_expected.to contain_nrpe__command('check_mysql_config')
            .with({
              'ensure'  => 'present',
              'command' => 'check_mysql_config',
            })
          }

        end
      end
    end
  end

end
