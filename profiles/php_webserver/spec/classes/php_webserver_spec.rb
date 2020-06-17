require 'spec_helper'

describe 'php_webserver' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "php_webserver class without any parameters and one application" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('php_webserver') }
          it { is_expected.to contain_class('php_webserver::params') }
          it { is_expected.to contain_class('archive') }

          it { is_expected.to contain_class('php::globals')
            .with({ 'php_version' => '5.6' })
            .that_comes_before( 'Class[php]')
          }
          it { is_expected.to contain_class('php')
            .with({
              'fpm'        => true,
              'dev'        => false,
              'composer'   => true,
              'pear'       => true,
              'phpunit'    => false,
              'settings'   => {
                'Date/date.timezone' => 'Europe/Brussels',
              },
              'extensions' => {},
             })
          }
          it { is_expected.to contain_class('apache')
            .with({ 'default_vhost' => false })
          }
          it { is_expected.to contain_class('apache::mod::rewrite') }
          it { is_expected.to contain_class('apache::mod::proxy')
            .that_comes_before( 'Class[apache::mod::proxy_fcgi]')
          }
          it { is_expected.to contain_class('apache::mod::proxy_fcgi') }

          it { is_expected.to contain_group('phpwebapp')
            .with({
              'ensure' => 'present',
              'gid'    => '151000'
            })
          }

          it { is_expected.to contain_file('/srv')
            .with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
          }

          it { is_expected.to contain_class('php_webserver::newrelic').with_enabled(false) }

          # Test of create_resources through hiera
          it { is_expected.to have_php_webserver__application_resource_count(1) }
          it { is_expected.to contain_php_webserver__application('my_php_application')
            .with({
              'development_mode'         => 'false',

              'vhost_name'               => 'foo.example.com',
              'vhost_aliases'            => [],

              'web_root_suffix'          => '',

              'webapp_user'              => 'my_php_application',
              'webapp_group'             => 'phpwebapp',

              'fpm_listen'               => '127.0.0.1:9001',

              'ssl_enabled'              => 'false',
              'ssl_only'                 => 'false',

              'directoryindex'           => 'index.php',
              'set_env'                  => {},

              'security_headers_enabled' => 'false',
              'security_headers'         => {
                'Content-Security-Policy'   => 'default-src \'self\' *.ugent.be \'unsafe-inline\' \'unsafe-eval\';',
                'Strict-Transport-Security' => 'max-age=63072000; includeSubdomains;',
                'X-Content-Type-Options'    => 'nosniff',
                'X-Frame-Options'           => 'SAMEORIGIN',
                'X-Xss-Protection'          => '1; mode=block',
                'Referrer-Policy'           => 'origin',
              },
            })
          }

          it { is_expected.to contain_user('my_php_application')
            .with({
              'ensure'     => 'present',
              'shell'      => '/bin/bash',
              'uid'        => 151001,
              'gid'        => 151000,
              'managehome' => true,
              'comment'    => 'php applicatie user',
            })
          }

          it { is_expected.to contain_file('/var/www/my_php_application')
            .with({
              'ensure' => 'directory',
              'mode'   => '0755',
              'owner'  => 'my_php_application',
              'group'  => 'phpwebapp',
            })
          }
          it { is_expected.to contain_file('/srv/my_php_application')
            .with({
              'ensure' => 'directory',
              'owner'  => 'my_php_application',
              'group'  => 'phpwebapp',
              'mode'   => '0751',
            })
          }
          it { is_expected.to contain_file('/tmp/127.0.0.1:9001')
            .with({
              'ensure' => 'present',
              'owner'  => 'root',
              'group'  => 'root',
            })
          }
          it { is_expected.to contain_php__fpm__pool('my_php_application')
            .with({
              'listen' => '127.0.0.1:9001',
              'user'   => 'my_php_application',
              'group'  => 'phpwebapp',
            })
          }
          it { is_expected.to contain_apache__vhost('my_php_application')
            .with({
              'port' => 80,
              'docroot' => '/var/www/my_php_application',
              'override' => 'all',
              'custom_fragment' => "<Proxy fcgi://127.0.0.1:9001>
    ProxySet timeout=1800
  </Proxy>
  ProxyPassMatch ^/(.*\\.php(/.*)?)$ fcgi://127.0.0.1:9001/var/www/my_php_application/$1 timeout=1800",
              'directoryindex' => 'index.php',
              'manage_docroot' => false,
              'servername' => 'foo.example.com',
              'serveraliases' => [],
              'setenv' => [],
            })
          }
        end

        context "php_webserver class with newrelic_enabled true" do
          let :params do {
              :newrelic_enabled => true,
          }
          end
          it { is_expected.to contain_class('php_webserver::newrelic').with_enabled(true) }
        end

      end
    end
  end

end
