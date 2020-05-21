require 'spec_helper'

describe 'mysql_server' do

  let(:default_params) do
    {
      :orchestrator_topology_user       => 'orchestrator',
      :orchestrator_topology_pass       => 'orchestrator',
      :orchestrator_topology_privileges => ['SELECT', 'SUPER'],
      :orchestrator_hostnames           => ['1.2.3.4', '5.6.7.8'],

      :mysql_replication_user           => 'replication',
      :mysql_replication_pass           => 'replication',
      :mysql_replication_hosts          => ['8.7.6.5', '4.3.2.1'],

      :proxy_servers                    => ['12.34.56.78', '87.65.43.21'],
      :backend_users                    => {
        'tester1' => {
          'ensure'        => 'present',
          'username'      => 'tester1',
          'password'      => 'tester1',
        },
        'tester2' => {
          'ensure'        => 'present',
          'username'      => 'tester2',
          'password'      => 'tester2',
        },
        'tester3' => {
          'ensure'        => 'present',
          'username'      => 'tester3',
          'password'      => 'tester3',
        },
        'tester4' => {
          'ensure'        => 'absent',
          'username'      => 'tester4',
        },
        'tester5' => {
          'username'      => 'tester5',
        },
      },
      :mysql_grants                     => {
        'tester1' => {
          'ensure'        => 'present',
          'user'          => 'tester1',
          'database'      => 'tester1',
          'tables'        => '*',
          'privileges'    => ['ALL']
        },
        'tester2' => {
          'ensure'        => 'present',
          'user'          => 'tester2',
          'database'      => 'tester2',
          'tables'        => '*',
          'privileges'    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE']
        },
        'tester3' => {
          'ensure'        => 'present',
          'user'          => 'tester3',
          'database'      => '*',
          'tables'        => '*',
          'privileges'    => ['ALL'],
          'options'       => ['GRANT']
        },
        'tester4' => {
          'ensure'        => 'absent',
          'user'          => 'tester4',
          'database'      => '*',
          'tables'        => '*',
          'privileges'    => ['NONE'],
        },
        'tester5' => {
          'user'          => 'tester5',
        },
      },
    }
  end

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

        context "mysql_server::users class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server::users') }

        end

        context "mysql_server::users class with default parameters" do
          let(:params) do
            default_params
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server::users') }

          it { is_expected.to contain_mysql_user('orchestrator@1.2.3.4')
            .with({
              'ensure' => 'present',
              'password_hash' => '*0AD183209365CECFB9275669074B645DFEF2D180',
            })
          }

          it { is_expected.to contain_mysql_grant('orchestrator@1.2.3.4/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['SELECT', 'SUPER'],
              'table'      => '*.*',
              'user'       => 'orchestrator@1.2.3.4',
            })
          }

          it { is_expected.to contain_mysql_grant('orchestrator@1.2.3.4/mysql.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['SELECT'],
              'table'      => 'mysql.*',
              'user'       => 'orchestrator@1.2.3.4',
            })
          }

          it { is_expected.to contain_mysql_user('orchestrator@5.6.7.8')
            .with({
              'ensure' => 'present',
              'password_hash' => '*0AD183209365CECFB9275669074B645DFEF2D180',
            })
          }

          it { is_expected.to contain_mysql_grant('orchestrator@5.6.7.8/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['SELECT', 'SUPER'],
              'table'      => '*.*',
              'user'       => 'orchestrator@5.6.7.8',
            })
          }

          it { is_expected.to contain_mysql_user('nagios@127.0.0.1')
            .with({
              'ensure' => 'present',
              'password_hash' => '*EC9067A2F2522D99C6D0F4720524027478CC0D8E',
            })
          }

          it { is_expected.to contain_mysql_grant('nagios@127.0.0.1/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['REPLICATION CLIENT'],
              'table'      => '*.*',
              'user'       => 'nagios@127.0.0.1',
            })
          }

          it { is_expected.to contain_mysql_grant('orchestrator@5.6.7.8/mysql.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['SELECT'],
              'table'      => 'mysql.*',
              'user'       => 'orchestrator@5.6.7.8',
            })
          }

          it { is_expected.to contain_mysql_user('replication@8.7.6.5')
            .with({
              'ensure' => 'present',
              'password_hash' => '*D36660B5249B066D7AC5A1A14CECB71D36944CBC',
            })
          }

          it { is_expected.to contain_mysql_grant('replication@8.7.6.5/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['REPLICATION SLAVE'],
              'table'      => '*.*',
              'user'       => 'replication@8.7.6.5',
            })
          }

          it { is_expected.to contain_mysql_user('replication@4.3.2.1')
            .with({
              'ensure' => 'present',
              'password_hash' => '*D36660B5249B066D7AC5A1A14CECB71D36944CBC',
            })
          }

          it { is_expected.to contain_mysql_grant('replication@4.3.2.1/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['REPLICATION SLAVE'],
              'table'      => '*.*',
              'user'       => 'replication@4.3.2.1',
            })
          }

          it { is_expected.to contain_mysql_user('tester1@12.34.56.78')
            .with({
              'ensure' => 'present',
              'password_hash' => '*E59491D11A8435314B4ABA637C3B60952908BEBE',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
            })
          }

          it { is_expected.to contain_mysql_grant('tester1@12.34.56.78/tester1.*')
            .with({
              'ensure'     => 'present',
              'options'    => [],
              'privileges' => ['ALL'],
              'table'      => 'tester1.*',
              'user'       => 'tester1@12.34.56.78',
            })
          }

          it { is_expected.to contain_mysql_user('tester1@87.65.43.21')
            .with({
              'ensure' => 'present',
              'password_hash' => '*E59491D11A8435314B4ABA637C3B60952908BEBE',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
          })
          }

          it { is_expected.to contain_mysql_grant('tester1@87.65.43.21/tester1.*')
            .with({
              'ensure'     => 'present',
              'options'    => [],
              'privileges' => ['ALL'],
              'table'      => 'tester1.*',
              'user'       => 'tester1@87.65.43.21',
            })
          }

          it { is_expected.to contain_mysql_user('tester2@12.34.56.78')
            .with({
              'ensure' => 'present',
              'password_hash' => '*337D90AA815113C121B6F05B5F57C63939D2888E',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
          })
          }

          it { is_expected.to contain_mysql_grant('tester2@12.34.56.78/tester2.*')
            .with({
              'ensure'     => 'present',
              'options'    => [],
              'privileges' => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
              'table'      => 'tester2.*',
              'user'       => 'tester2@12.34.56.78',
            })
          }

          it { is_expected.to contain_mysql_user('tester2@87.65.43.21')
            .with({
              'ensure' => 'present',
              'password_hash' => '*337D90AA815113C121B6F05B5F57C63939D2888E',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
        })
          }

          it { is_expected.to contain_mysql_grant('tester2@87.65.43.21/tester2.*')
            .with({
              'ensure'     => 'present',
              'options'    => [],
              'privileges' => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
              'table'      => 'tester2.*',
              'user'       => 'tester2@87.65.43.21',
            })
          }

          it { is_expected.to contain_mysql_user('tester3@12.34.56.78')
            .with({
              'ensure' => 'present',
              'password_hash' => '*53BE46371046A9D4539E43E8CD83FAA9E00631D6',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
            })
          }

          it { is_expected.to contain_mysql_grant('tester3@12.34.56.78/*.*')
            .with({
              'ensure'     => 'present',
              'options'    => ['GRANT'],
              'privileges' => ['ALL'],
              'table'      => '*.*',
              'user'       => 'tester3@12.34.56.78',
            })
          }

          it { is_expected.to contain_mysql_user('tester3@87.65.43.21')
            .with({
              'ensure' => 'present',
              'password_hash' => '*53BE46371046A9D4539E43E8CD83FAA9E00631D6',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
          })
          }

          it { is_expected.to contain_mysql_grant('tester3@87.65.43.21/*.*')
            .with({
              'ensure'     => 'present',
              'options'    => ['GRANT'],
              'privileges' => ['ALL'],
              'table'      => '*.*',
              'user'       => 'tester3@87.65.43.21',
            })
          }

          it { is_expected.to contain_mysql_user('tester4@12.34.56.78')
            .with({
              'ensure' => 'absent',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
            })
          }

          it { is_expected.to contain_mysql_grant('tester4@12.34.56.78/*.*')
            .with({
              'ensure'     => 'absent',
              'privileges' => ['NONE'],
              'table'      => '*.*',
              'user'       => 'tester4@12.34.56.78',
            })
          }

          it { is_expected.to contain_mysql_user('tester4@87.65.43.21')
            .with({
              'ensure' => 'absent',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
            })
          }

          it { is_expected.to contain_mysql_grant('tester4@87.65.43.21/*.*')
            .with({
              'ensure'     => 'absent',
              'privileges' => ['NONE'],
              'table'      => '*.*',
              'user'       => 'tester4@87.65.43.21',
            })
          }

          it { is_expected.to contain_mysql_user('tester5@12.34.56.78')
            .with({
              'ensure' => 'present',
              'password_hash' => '',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
	    })
          }

          it { is_expected.to contain_mysql_grant('tester5@12.34.56.78/*.*')
            .with({
              'ensure'     => 'present',
              'options'    => [],
              'privileges' => ['NONE'],
              'table'      => '*.*',
              'user'       => 'tester5@12.34.56.78',
            })
          }

          it { is_expected.to contain_mysql_user('tester5@87.65.43.21')
            .with({
              'ensure' => 'present',
              'password_hash' => '',
              'tag'           => [ 'mysql_backend_user', 'mysql-cluster-friendly-name' ],
	    })
          }

          it { is_expected.to contain_mysql_grant('tester5@87.65.43.21/*.*')
            .with({
              'ensure'     => 'present',
              'options'    => [],
              'privileges' => ['NONE'],
              'table'      => '*.*',
              'user'       => 'tester5@87.65.43.21',
            })
          }

          it { is_expected.to contain_mysql_user('monitor@12.34.56.78')
            .with({
              'ensure' => 'present',
              'password_hash' => '*1975D095AC033CAF4E1BF94F7202A9BBFEEB66F1',
            })
          }

          it { is_expected.to contain_mysql_grant('monitor@12.34.56.78/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['REPLICATION CLIENT'],
              'table'      => '*.*',
              'user'       => 'monitor@12.34.56.78',
            })
          }

          it { is_expected.to contain_mysql_user('monitor@87.65.43.21')
            .with({
              'ensure' => 'present',
              'password_hash' => '*1975D095AC033CAF4E1BF94F7202A9BBFEEB66F1',
            })
          }

          it { is_expected.to contain_mysql_grant('monitor@87.65.43.21/*.*')
            .with({
              'ensure'     => 'present',
              'privileges' => ['REPLICATION CLIENT'],
              'table'      => '*.*',
              'user'       => 'monitor@87.65.43.21',
            })
          }

        end

        context "mysql_server::users class with backend_users should be a hash" do
          let(:params) do
            default_params.merge({
              :backend_users => 'no_hash'
            })
          end

          it { is_expected.to compile.and_raise_error(/parameter 'backend_users' expects a Hash value/) }
        end

        context "mysql_server::users class with backend_users, user instance should be a hash" do
          let(:params) do
            default_params.merge({
              :backend_users => {
                'tester6' => 'no_hash',
              }
            })
          end

          it { is_expected.to compile.and_raise_error(/block parameter 'backend_user' expects a Hash value/) }
        end

        context "mysql_server::users class with backend_users without username" do
          let(:params) do
            default_params.merge({
              :backend_users => {
                'tester6' => {},
              }
            })
          end

          it { is_expected.to compile.and_raise_error(/backend_user parameter username should not be empty/) }
        end

        context "mysql_server::users class with backend_users with an empty username" do
          let(:params) do
            default_params.merge({
              :backend_users => {
                'tester6' => {
		  'username' => '',
		},
              }
            })
          end

          it { is_expected.to compile.and_raise_error(/backend_user parameter username should not be empty/) }
        end

        context "mysql_server::users class with mysql_grants should be a hash" do
          let(:params) do
            default_params.merge({
              :mysql_grants => 'no_hash'
            })
          end

          it { is_expected.to compile.and_raise_error(/parameter 'mysql_grants' expects a Hash value/) }
        end

        context "mysql_server::users class with mysql_grants, grant instance should be a hash" do
          let(:params) do
            default_params.merge({
              :mysql_grants => {
                'tester6' => 'no_hash',
              }
            })
          end

          it { is_expected.to compile.and_raise_error(/block parameter 'mysql_grant' expects a Hash value/) }
        end

        context "mysql_server::users class with mysql_grants without username" do
          let(:params) do
            default_params.merge({
              :mysql_grants => {
                'tester6' => {},
              }
            })
          end

          it { is_expected.to compile.and_raise_error(/mysql_grant parameter user should not be empty/) }
        end

        context "mysql_server::users class with mysql_grants with an empty username" do
          let(:params) do
            default_params.merge({
              :mysql_grants => {
                'tester6' => {
                  'user' => '',
		},
              }
            })
          end

          it { is_expected.to compile.and_raise_error(/mysql_grant parameter user should not be empty/) }
        end

      end
    end
  end

end
