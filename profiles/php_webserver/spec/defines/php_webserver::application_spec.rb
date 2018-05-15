require 'spec_helper'

# fpm_listen is set to 9002 because in our test of ::php_webserver
# we have already an application defined that is created by the
# create_resources function in init.pp
describe 'php_webserver::application', :type => :define do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        let(:pre_condition) { 'include ::php_webserver' }
        context "php_webserver::application with params" do
          let(:title) { 'krypton' }
          let(:params) do
            {
              :development_mode => true,
              :vhost_name => 'krypton.planet',
              :vhost_aliases => [ 'earth.planet', 'mars.planet' ],
              :webapp_user => 'ckent',
              :fpm_listen => '0.0.0.0:9002',
            }
          end

          it { is_expected.to compile }

          it { is_expected.to contain_php_webserver__application('krypton')
            .with({
              'development_mode'         => 'true',

              'vhost_name'               => 'krypton.planet',
              'vhost_aliases'            => [ 'earth.planet', 'mars.planet' ],

              'web_root_suffix'          => '',

              'webapp_user'              => 'ckent',
              'webapp_group'             => 'phpwebapp',

              'fpm_listen'               => '0.0.0.0:9002',

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

          it { is_expected.to contain_user('ckent')
            .with({
              'ensure'     => 'present',
              'shell'      => '/bin/bash',
              'uid'        => 151002,
              'gid'        => 151000,
              'managehome' => true,
              'comment'    => 'php applicatie user',
            })
          }

          it { is_expected.to contain_file('/var/www/krypton')
            .with({
              'ensure' => 'directory',
              'mode'   => '0755',
              'owner'  => 'ckent',
              'group'  => 'phpwebapp',
            })
          }
          it { is_expected.to contain_file('/srv/krypton')
            .with({
              'ensure' => 'directory',
              'owner'  => 'ckent',
              'group'  => 'phpwebapp',
              'mode'   => '0751',
            })
          }
          it { is_expected.to contain_file('/tmp/0.0.0.0:9002')
            .with({
              'ensure' => 'present',
              'owner'  => 'root',
              'group'  => 'root',
            })
          }
          it { is_expected.to contain_php__fpm__pool('krypton')
            .with({
              'listen' => '0.0.0.0:9002',
              'user'   => 'ckent',
              'group'  => 'phpwebapp',
            })
          }
          it { is_expected.to contain_apache__vhost('krypton')
            .with({
              'port'     => 80,
              'docroot'  => '/var/www/krypton',
              'override' => 'all',
              'custom_fragment' => "<Proxy fcgi://0.0.0.0:9002>
    ProxySet timeout=1800
  </Proxy>
  ProxyPassMatch ^/(.*\\.php(/.*)?)$ fcgi://0.0.0.0:9002/var/www/krypton/$1 timeout=1800",
              'directoryindex' => 'index.php',
              'manage_docroot' => false,
              'servername' => 'krypton.planet',
              'serveraliases' => [ 'earth.planet', 'mars.planet'],
              'setenv' => [],
            })
          }
          it { is_expected.not_to contain_sslcert__cert('krypton.planet') }
        end

        context "php_webserver::application with params and SSL turned on, but no certificates" do
          let(:title) { 'krypton' }
          let(:params) do
            {
              :development_mode => true,
              :vhost_name => 'krypton.planet',
              :vhost_aliases => [ 'earth.planet', 'mars.planet' ],
              :webapp_user => 'ckent',
              :webapp_group => 'superheroes',
              :fpm_listen => '0.0.0.0:9002',
              :ssl_enabled => true,
            }
          end
          it { is_expected.to compile.and_raise_error(/No SSL cert for vhost krypton.planet passed/) }
        end

        context "php_webserver::application with params and SSL only on, but no certificates" do
          let(:title) { 'krypton' }
          let(:params) do
            {
              :development_mode => true,
              :vhost_name => 'krypton.planet',
              :vhost_aliases => [ 'earth.planet', 'mars.planet' ],
              :webapp_user => 'ckent',
              :webapp_group => 'superheroes',
              :fpm_listen => '0.0.0.0:9002',
              :ssl_enabled => true,
              :ssl_only => true,
            }
          end
          it { is_expected.to compile.and_raise_error(/No SSL cert for vhost krypton.planet passed/) }
        end

        context "php_webserver::application with params and SSL only on, but wrong certificate name" do
          let(:title) { 'krypton' }
          let(:params) do
            {
              :development_mode => true,
              :vhost_name => 'krypton.planet',
              :vhost_aliases => [ 'earth.planet', 'mars.planet' ],
              :webapp_user => 'ckent',
              :webapp_group => 'superheroes',
              :fpm_listen => '0.0.0.0:9002',
              :ssl_enabled => true,
              :ssl_only => true,
              :ssl_certificates => { 'krypton.galaxy' => { 'certname' => 'certname', 'csr' => 'csr', 'cert' => 'cert', 'chain' => 'chain' }},
            }
          end
          it { is_expected.to compile.and_raise_error(/No SSL cert for vhost krypton.planet passed/) }
        end

        context "php_webserver::application with params and SSL turned on" do
          let(:title) { 'krypton' }
          let(:params) do
            {
              :development_mode => true,
              :vhost_name => 'krypton.planet',
              :vhost_aliases => [ 'earth.planet', 'mars.planet' ],
              :webapp_user => 'ckent',
              :webapp_group => 'superheroes',
              :fpm_listen => '0.0.0.0:9002',
              :ssl_enabled => true,
              :ssl_certificates => { 'krypton.planet' => { 'certname' => 'certname', 'csr' => 'csr', 'cert' => 'cert', 'chain' => 'chain' }},
            }
          end

          it { is_expected.to compile }

          it { is_expected.to contain_sslcert__cert('krypton.planet') }
          it { is_expected.to contain_apache__vhost('krypton_ssl')
            .with({
              'port' => 443,
              'ssl' => true,
              'ssl_cert' => '/etc/ssl/certs/krypton.planet',
              'ssl_key' => '/etc/ssl/private/krypton.planet.key',
              'ssl_chain' => '/etc/ssl/certs/krypton.planet.chain',
              'docroot' => '/var/www/krypton',
              'override' => 'all',
              'custom_fragment' => "<Proxy fcgi://0.0.0.0:9002>
    ProxySet timeout=1800
  </Proxy>
  ProxyPassMatch ^/(.*\\.php(/.*)?)$ fcgi://0.0.0.0:9002/var/www/krypton/$1 timeout=1800",
              'directoryindex' => 'index.php',
              'manage_docroot' => false,
              'servername' => 'krypton.planet',
              'serveraliases' => [ 'earth.planet', 'mars.planet'],
              'setenv' => [],
            })
          }
        end

        context "php_webserver::application with params and SSL-only turned on" do
          let(:title) { 'krypton' }
          let(:params) do
            {
              :development_mode => true,
              :vhost_name => 'krypton.planet',
              :vhost_aliases => [ 'earth.planet', 'mars.planet' ],
              :webapp_user => 'ckent',
              :webapp_group => 'superheroes',
              :fpm_listen => '0.0.0.0:9002',
              :ssl_enabled => true,
              :ssl_only => true,
              :ssl_certificates => { 'krypton.planet' => { 'certname' => 'certname', 'csr' => 'csr', 'cert' => 'cert', 'chain' => 'chain' }},
            }
          end

          it { is_expected.to compile }

          it { is_expected.to contain_sslcert__cert('krypton.planet') }
          it { is_expected.to contain_apache__vhost('krypton')
            .with({
              'port'            => 80,
              'docroot'         => '/var/www/html',
              'manage_docroot'  => false,
              'servername'      => 'krypton.planet',
              'serveraliases'   => [ 'earth.planet', 'mars.planet'],
              'rewrites' => [ { 'comment'      => 'redirect to https',
                                'rewrite_cond' => ['%{HTTPS} !=on'],
                                'rewrite_rule' => ['.* https://%{HTTP_HOST}%{REQUEST_URI} [R=301,L]'],
              },],
            })
          }
        end

        context "php_webserver::appliction with share mounted" do
          let(:title) { 'krypton' }
          let(:facts) do
            facts.merge({ :hostname => 'testhost', :ipaddress => '157.193.40.1' })
          end
          let(:params) do
            {
              :webapp_user => 'ckent',
              :webapp_group => 'superheroes',
              :mount_share => true,
              :sharename   => 'northpole',
              :fpm_listen => '0.0.0.0:9002',
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_file('/srv/krypton')
            .with({
              'ensure' => 'directory',
              'owner'  => 'ckent',
              'group'  => 'superheroes',
              'mode'   => '0751',
            })
          }
          it { is_expected.to contain_nshares__mount('/srv/krypton')
            .with({
              'sharename' => 'northpole',
            })
          }
        end

        context "php_webserver::appliction with ensure absent" do
          let(:title) { 'my_php_application_absent' }
          let(:params) do
            {
              :ensure => 'absent',
              :fpm_listen => '0.0.0.0:9002',
            }
          end

          it { is_expected.to compile }

          it { is_expected.to contain_php_webserver__application('my_php_application_absent')
            .with({
              'ensure' => 'absent'
            })
          }

          it { is_expected.not_to contain_user('my_php_application_absent') }

          it { is_expected.to contain_file('/var/www/my_php_application_absent')
            .with({
              'ensure' => 'absent',
            })
          }
          it { is_expected.to contain_file('/srv/my_php_application_absent')
            .with({
              'ensure' => 'absent',
            })
          }
          it { is_expected.to contain_file('/tmp/0.0.0.0:9002')
            .with({
              'ensure' => 'absent',
            })
          }
          it { is_expected.to contain_php__fpm__pool('my_php_application_absent')
            .with({
              'ensure' => 'absent',
            })
          }
          it { is_expected.to contain_apache__vhost('my_php_application_absent')
            .with({
              'ensure' => 'absent',
            })
          }
        end
      end
    end
  end
end
