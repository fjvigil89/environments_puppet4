require 'spec_helper'

describe 'mysql_server' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :hostname        => 'testhost',
            :ipaddress       => '157.193.40.1',
            :mysql_version   => '5.7.17',
            :mysqld_readonly => 'OFF',
          })
        end

        context "mysql_server class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server')
            .with({
              'root_password' => 'SuperSecretPassword',
              'cluster_name'  => 'mysql-cluster-friendly-name',
            })
          }

          it { is_expected.to contain_mysql_plugin('rpl_semi_sync_master')
            .with({
              'ensure' => 'absent',
              'soname' => 'semisync_master.so',
            })
          }

          it { is_expected.to contain_mysql_plugin('rpl_semi_sync_slave')
            .with({
              'ensure' => 'absent',
              'soname' => 'semisync_slave.so',
            })
          }

          it { is_expected.to contain_class('mysql_server::params') }
          it { is_expected.to contain_class('mysql_server::repo') }

          it { is_expected.to contain_class('mysql::client')
            .with({
              'package_name' => 'percona-server-client-5.7'
            })
          }
          it { is_expected.to contain_class('mysql::server')
            .with({
              'package_name'            => 'percona-server-server-5.7',
              'root_password'           => 'SuperSecretPassword',
              'remove_default_accounts' => true,
            })
          }
          it { is_expected.to contain_package('percona-toolkit') }
          it { is_expected.to contain_package('percona-xtrabackup-24') }

          it { is_expected.to contain_class('mysql_server::users')
            .with({
              'orchestrator_topology_user'       => 'orchestrator',
              'orchestrator_topology_pass'       => '',
              'orchestrator_topology_privileges' => [],
              'orchestrator_hostnames'           => [],

              'mysql_replication_user'           => 'replication',
              'mysql_replication_pass'           => '',
              'mysql_replication_hosts'          => [],

              'proxy_servers'                    => [],

              'mysql_monitor_username'           => 'monitor',
              'mysql_monitor_password'           => 'monitor',

              'backend_users'                    => {},
              'mysql_grants'                     => {},
            })
          }

          it { is_expected.to contain_package('libjemalloc1')
            .with({
              'ensure' => 'installed',
            })
          }

          it { is_expected.to contain_package('numactl')
            .with({
              'ensure' => 'installed',
            })
          }

          it { is_expected.to contain_file('/root/mysql_cluster_info.sql')
            .with({
              'ensure'  => 'absent',
            })
          }

          it { is_expected.to contain_systemd__service_limits('mysql.service')
            .with({
              'limits' => {
                'LimitNOFILE' => 65535,
                'LimitNPROC'  => 65535,
              }
            })
          }

          it { is_expected.to contain_logrotate__rule('mysql-error-log')
            .with({
              'path'         => '/var/log/mysql/error.log',
              'rotate'       => 5,
              'rotate_every' => 'week',
              'postrotate'   => '/usr/bin/mysqladmin flush-logs error',
            })
          }

          it { is_expected.to contain_file('/tmp/mysql_cluster_info.sql')
            .with({
              'ensure'  => 'file',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0400',
            })
          }

          it { is_expected.not_to contain_exec('load-cluster-info-info-mysql')
            .with({
              'command'     => '/bin/cat /tmp/mysql_cluster_info.sql | mysql --defaults-file=/root/.my.cnf',
              'refreshonly' => true,
            })
          }

          it { is_expected.to contain_file('/usr/local/sbin/mysql_start_replication')
            .with({
              'ensure'  => 'file',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0750',
            })
          }

        end


        context "mysql_server class with device parameter" do
          let :params do
            { :datadir_device => '/dev/my-disk' }
          end
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server') }
          it { is_expected.to contain_mount('/var/lib/mysql').with({
              'ensure'  => 'mounted',
              'device'  => '/dev/my-disk',
              'fstype'  => 'ext4',
              'options' => '_netdev,rw,nosuid,nodev,acl,user_xattr,nobarrier',
              'before'  => 'Class[Mysql::Server]',
            })
          }

        end

        context "mysql_server class with enable_rpl_semi_sync_plugin set to true" do
          let :params do
            { :enable_rpl_semi_sync_plugin => true }
          end
          it { is_expected.to contain_mysql_plugin('rpl_semi_sync_master')
            .with({
              'ensure' => 'present',
              'soname' => 'semisync_master.so',
            })
          }

          it { is_expected.to contain_mysql_plugin('rpl_semi_sync_slave')
            .with({
              'ensure' => 'present',
              'soname' => 'semisync_slave.so',
            })
          }
        end

        context "mysql_server in read only mode" do
          let(:facts) do
            facts.merge({
              :mysql_version   => '5.7.17',
              :mysqld_readonly => 'ON',
            })
          end
          it { is_expected.not_to contain_mysql_plugin('mysql_server::user') }
        end

        context "mysql_server in undefined mode" do
          let(:facts) do
            facts.merge({
              :mysql_version   => '5.7.17',
              :mysqld_readonly => '',
            })
          end
          it { is_expected.not_to contain_mysql_plugin('mysql_server::user') }
        end

      end
    end
  end

end
