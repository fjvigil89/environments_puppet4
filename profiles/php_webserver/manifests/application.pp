# Class: php_webserver
# ===========================
#
# Full description of class php_webserver here.
#
#
define php_webserver::application (
  Enum['present', 'absent'] $ensure  = $::php_webserver::params::application_ensure,
  Boolean $development_mode         = $::php_webserver::params::development_mode,

  String $vhost_name                = $::php_webserver::params::vhost_name,
  Array $vhost_aliases              = $::php_webserver::params::vhost_aliases,

  String $web_root_suffix           = $::php_webserver::params::web_root_suffix,

  String $webapp_user               = $name,
  String $webapp_group              = $::php_webserver::params::webapp_group,

  String $fpm_listen                = $::php_webserver::params::fpm_listen,

  Boolean $ssl_enabled              = $::php_webserver::params::ssl_enabled,
  Boolean $ssl_only                 = $::php_webserver::params::ssl_only,
  Hash $ssl_certificates            = $::php_webserver::params::ssl_certificates,

  Boolean $create_data_dir          = $::php_webserver::params::create_application_data_dir,
  String $directoryindex            = $::php_webserver::params::directoryindex,
  Hash $set_env                     = $::php_webserver::params::set_env,

  Boolean $lvs_enabled              = $::php_webserver::params::lvs_enabled,
  String $lvs_ip                    = $::php_webserver::params::lvs_ip,
  String $lvs_device                = $::php_webserver::params::lvs_device,

  Boolean $mount_share              = $::php_webserver::params::mount_share,
  String $sharename                 = $::php_webserver::params::sharename,

  Boolean $security_headers_enabled = $::php_webserver::params::security_headers_enable,
  Hash $security_headers            = $::php_webserver::params::default_security_headers,
) {

  # The base class must be included first because it is used by parameter defaults
  if !defined(Class['php_webserver']) {
    fail('You must include the php_webserver base class before using any php_webserver defined resources')
  }

  if $ssl_only or $ssl_enabled {
    unless has_key($ssl_certificates, $vhost_name) {
      fail("No SSL cert for vhost ${vhost_name} passed")
    }
  }

  include ::php_webserver::params

  $webapp_name = $name

  $directory_ensure = $ensure ? {
    'absent' => 'absent',
    default  => directory,
  }

  if $web_root_suffix == '' {
    $webapp_root_dir = "${::php_webserver::params::webapp_root_dir}/${webapp_name}"
  } else {

    file { "${::php_webserver::params::webapp_root_dir}/${webapp_name}":
      ensure => $directory_ensure,
      mode   => '0755',
      owner  => $webapp_user,
      group  => $webapp_group,
    }

    $webapp_root_dir = "${::php_webserver::params::webapp_root_dir}/${webapp_name}/${web_root_suffix}"
  }

  User <| title == $webapp_user |> {
    ensure => $ensure,
  }

  # Add configuration below
  file { $webapp_root_dir:
    ensure => $directory_ensure,
    mode   => '0755',
    owner  => $webapp_user,
    group  => $webapp_group,
  }

  if($create_data_dir) {
    file { "${php_webserver::datadir_base}/${webapp_name}":
      ensure  => $directory_ensure,
      owner   => $webapp_user,
      group   => $webapp_group,
      mode    => '0751',
      require => File[$php_webserver::datadir_base],
    }

    if($mount_share) {
      if($sharename == '') {
        fail('When mount_share is set to true, you are required to provide a sharename')
      }

      nshares::mount{ "${php_webserver::datadir_base}/${webapp_name}":
        ensure    => $ensure,
        sharename => $sharename,
      }
    }
  }


  file { "/tmp/${fpm_listen}":
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
  }

  if $fpm_listen != '127.0.0.1:9000' {
    # 127.0.0.1:9000 is used by the default www pool
    php::fpm::pool { $webapp_name:
      ensure => $ensure,
      listen => $fpm_listen,
      user   => $webapp_user,
      group  => $webapp_group,
    }
  }

  $fastcgi_socket = "fcgi://${fpm_listen}${webapp_root_dir}/\$1"
  $apache_set_env = $set_env.map |$key, $value| { "${key} ${value}" }
  $apache_set_env_if = [
    'Authorization "(.*)" HTTP_AUTHORIZATION=$1',
  ]

  if $security_headers_enabled {
    $apache_security_headers = $security_headers.map |$key, $value| { "always set ${key} \"${value}\"" }
  } else {
    $apache_security_headers = []
  }

  if $ssl_only and $ssl_enabled {
    apache::vhost { $webapp_name:
      ensure         => $ensure,
      port           => 80,
      servername     => $vhost_name,
      serveraliases  => $vhost_aliases,
      docroot        => '/var/www/html',
      manage_docroot => false,
      rewrites       => [
        {
          comment      => 'redirect to https',
          rewrite_cond => ['%{HTTPS} !=on'],
          rewrite_rule => ['.* https://%{HTTP_HOST}%{REQUEST_URI} [R=301,L]'],
        },
      ],
    }
  }else {
    apache::vhost { $webapp_name:
      ensure          => $ensure,
      port            => 80,
      docroot         => $webapp_root_dir,
      override        => 'all',
      custom_fragment => "<Proxy fcgi://${fpm_listen}>
    ProxySet timeout=1800
  </Proxy>
  ProxyPassMatch ^/(.*\\.php(/.*)?)$ ${fastcgi_socket} timeout=1800",
      directoryindex  => $directoryindex,
      manage_docroot  => false,
      servername      => $vhost_name,
      serveraliases   => $vhost_aliases,
      setenv          => $apache_set_env,
      setenvif        => $apache_set_env_if,
    }
  }


  if $ssl_enabled {
    class { '::sslcert':
      certificates => $ssl_certificates,
    }

    Class['::sslcert::config'] ~> Service[$::apache::service_name]

    apache::vhost { "${webapp_name}_ssl":
      ensure          => $ensure,
      port            => 443,
      ssl             => true,
      ssl_cert        => "/etc/ssl/certs/${vhost_name}",
      ssl_key         => "/etc/ssl/private/${vhost_name}.key",
      ssl_chain       => "/etc/ssl/certs/${vhost_name}.chain",
      docroot         => $webapp_root_dir,
      override        => 'all',
      custom_fragment => "<Proxy fcgi://${fpm_listen}>
    ProxySet timeout=1800
  </Proxy>
  ProxyPassMatch ^/(.*\\.php(/.*)?)$ ${fastcgi_socket} timeout=1800",
      directoryindex  => $directoryindex,
      manage_docroot  => false,
      servername      => $vhost_name,
      serveraliases   => $vhost_aliases,
      setenv          => $apache_set_env,
      setenvif        => $apache_set_env_if,
      headers         => $apache_security_headers,
    }
  }

}
