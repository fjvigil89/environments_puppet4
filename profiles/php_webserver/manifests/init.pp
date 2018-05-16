# Class: php_webserver
# ===========================
#
# Full description of class php_webserver here.
#
#
class php_webserver (
  Boolean $development_mode     = $::php_webserver::params::development_mode,
  String $php_version           = $::php_webserver::params::php_version,

  Hash $webapp_users            = $::php_webserver::params::webapp_users,
  Hash $webapp_user_defaults    = $::php_webserver::params::webapp_user_defaults,

  String $webapp_group          = $::php_webserver::params::webapp_group,
  Integer $webapp_gid           = $::php_webserver::params::webapp_gid,

  String $datadir_base          = $::php_webserver::params::datadir_base,
  String $datadir_base_owner    = $::php_webserver::params::datadir_base_owner,
  String $datadir_base_group    = $::php_webserver::params::datadir_base_group,

  # PHP Settings and Extensions
  Hash $php_settings            = $::php_webserver::params::php_settings,
  Hash $php_extensions          = $::php_webserver::params::php_extensions,

  # Mod Security settings
  Boolean $mod_security_enabled = $::php_webserver::params::mod_security_enabled,
  String $mod_security_mode     = $::php_webserver::params::mod_security_mode,
  Array $mod_security_rules     = $::php_webserver::params::modsec_default_rules,

  # Newrelic enabled or not?
  Boolean $newrelic_enabled     = $::php_webserver::params::newrelic_enabled,

  # Aditional packages to install
  Array $packages                = [],
  Hash $applications             = {},
) inherits ::php_webserver::params {

  include '::archive'

  #$real_settings = deep_merge($::php_webserver::params::php_settings, $php_settings)
  #$real_extensions = deep_merge($::php_webserver::params::php_extensions, $php_extensions)

  file { $datadir_base:
    ensure => 'directory',
    owner  => $datadir_base_owner,
    group  => $datadir_base_group,
    mode   => '0755',
  }


  class { '::php::globals':
    php_version => $php_version,
    #config_root => '/etc/php/'$php_version,
  }
  -> class { '::php':
    manage_repos => false,
    fpm          => true,
    dev          => $development_mode,
    composer     => true,
    pear         => true,
    phpunit      => $development_mode,
    settings     => $php_settings,
    extensions   => $php_extensions,
  }

  #class { '::apache':
    #default_vhost => false,
    #mpm_module => 'prefork',
  #}

  # Load mod_rewrite if needed and not yet loaded
  #if ! defined(Class['apache::mod::rewrite']) {
    #include ::apache::mod::rewrite
  #}

  #class { '::apache::mod::proxy':; }
  #-> class { '::apache::mod::proxy_fcgi':; }

  #if $mod_security_enabled {
    #class { '::apache::mod::security':
      #activated_rules      => $mod_security_rules,
      #modsec_secruleengine => $mod_security_mode,

    #}
  #}

  group { $webapp_group:
    ensure => present,
    gid    => $webapp_gid,
  }

  # Newrelic setup
  class { '::php_webserver::newrelic':
    enabled => $::php_webserver::newrelic_enabled,
  }




#ll the webapp_users virtual, the application define will realize the users needed on this server...
  create_resources('@user', $webapp_users, $webapp_user_defaults)

  # Create applications if passed
  create_resources('php_webserver::application', $applications, {})

  # Manage aditional software
  ensure_packages($packages)
}
