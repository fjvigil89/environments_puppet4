# Class: otrs_instance
# ===========================
#
# Configueert een otrs stack
#
#
class otrs_instance (
  String $instance     ='upr',
  $otrs_id             = '01',
  $system_id           = '',
  $organization        = '',
  $mapping             = '',
  $server_name         = $::fqdn,
  $db_user             = 'root',
  $db_password         = '123',
  $db_name             = 'otrsprod',
  $vhost_aliases       = 'otrs.upr.edu.cu',
  $enable_ssl          = false,
  $enable_ssl_redirect = true,
  $admin_email         = 'upredes@upr.edu.cu',
  $db_host             = $::fqdn,
  $extra_settings      = {},
) {

  $otrs_data_dir = '/srv/otrs_data'
  $otrs_nfs_share = "otrs_data_${instance}"

  # Add configuration below
  #Accounts::User<| tag == 'otrs_admin' |>

  sudo::conf { 'otrs':
    priority => 1,
    content  => template('otrs_instance/sudo.erb');
  }

  file {'/srv/otrs_data':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0751',
  }

  nshares::mount{ $otrs_data_dir:
    ensure    => present,
    sharename => $otrs_nfs_share,
  }

  # Use http or https in OTRS links depending on SSL being enabled
  $otrs_ssl_on = $enable_ssl ? {
    true    => 'https',
    default => 'http',
  }

  # Common defaults for all intances, can be overridden in hiera through extra_settings
  $common_settings = {
    'SystemID'               => $system_id,
    'AdminEmail'             => $admin_email,
    'Organization'           => $organization,
    'FQDN'                   => $::fqdn,
    'CustomerHeadline'       => 'Veel gestelde vragen',
    'DefaultLanguage'        => 'nl',
    'SecureMode'             => '1',     # Lock the installer script
    'LogoutURL'              => 'https://login.ugent.be/logout',
    'PerformanceLog'         => '0',
    'PostMasterMaxEmailSize' => '25600', # 25MB mail size limit on relays
    'AuthModule'             => 'Kernel::System::Auth::HTTPBasicAuth',
    'HttpType'               => $otrs_ssl_on,
  }

  $full_settings = deep_merge($common_settings, $extra_settings)

  $full_config_block = template('otrs_instance/commons.erb')

  realize(User['otrs'])
  realize(Group['otrs'])

  class {'::otrs':
    installation_type  => 'web',
    database_connector => 'mysql',
    db_host            => $db_host,
    db_user            => $db_user,
    db_password        => $db_password,
    db_name            => $db_name,
    major_release      => 5,
    version            => '5.0.26',
    extra_packages     => [
      'libcrypt-ssleay-perl',
      'libapache2-mod-perl2',
    ],
    manage_database    => false,
    manage_webserver   => false,
    manage_user        => false,
    config_hash        => $full_settings,
    config_block       => $full_config_block,
  }

  # Deploy Apache running as the OTRS user
  class { '::apache':
    user          => $::otrs::params::user,
    manage_user   => false,
    default_vhost => false,
    mpm_module    => 'prefork', # Use the recommended multi-processing module in Apache
  }

  # Load the Apache Perl module
  include ::apache::mod::perl
  # Load the Apache headers module to improve UI speed
  include ::apache::mod::headers

  ::apache::vhost { 'otrs':
    port          => '80',
    docroot       => "${::otrs::params::base_dir}/var/httpd/htdocs/",
    docroot_owner => $::otrs::params::user,
    docroot_group => $::otrs::params::web_group,
  }

  # Enable Apache CAS Authentication Module
  #class {'::apache::mod::auth_cas':
  #  cas_login_url    => 'https://login.ugent.be/login',
  #  cas_validate_url => 'https://login.ugent.be/serviceValidate',
  #}

  # Defaults for the vhosts
  Apache::Vhost {
    servername    => $server_name,
    serveraliases => $vhost_aliases,
    port          => '80',
    priority      => '00',
    docroot       => "${::otrs::params::base_dir}/var/httpd/htdocs/",
    serveradmin   => $admin_email,
  }

  # Configure Vhosts depending on SSL enabling
  if $enable_ssl {

    include ::sslcert

    # Reload Apache upon SSL changes
    Class['::sslcert::config'] ~> Service[$::apache::params::service_name]

    if $enable_ssl_redirect {

      # Enable mod_rewrite to allow rewriting to https
      include ::apache::mod::rewrite

      apache::vhost { "${server_name}_80":
        rewrite_cond => '%{HTTPS} off',
        rewrite_rule => '(.*) https://%{HTTP_HOST}%{REQUEST_URI}',
      }
    } else {
      apache::vhost { "${server_name}_80":
        directories   => [
          {
            'path'            => '/otrs',
            'provider'        => 'location',
            'custom_fragment' => 'AuthType CAS',
            'require'         => 'valid-user',
          },
        ],
      }
    }

    apache::vhost { "${server_name}_443":
      port        => '443',
      ssl         => true,
      ssl_key     => "${::sslcert::keypath}/otrs${instance}.upr.edu.cu.key",
      ssl_cert    => "${::sslcert::certpath}/otrs${instance}.upr.edu.cu",
      ssl_chain   => "${::sslcert::certpath}/otrs${instance}.upr.edu.cu.chain",
      directories => [
        {
          'path'            => '/otrs',
          'provider'        => 'location',
          'custom_fragment' => 'AuthType CAS',
          'require'         => 'valid-user',
        },
      ],
    }
  } else {
    apache::vhost { "${server_name}_80":
      directories => [
        {
          'path'            => '/otrs',
          'provider'        => 'location',
          #'custom_fragment' => 'AuthType CAS',
          #'require'         => 'valid-user',
        },
      ],
    }
  }

}
