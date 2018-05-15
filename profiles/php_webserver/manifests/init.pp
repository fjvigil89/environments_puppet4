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

  file { $datadir_base:
    ensure => 'directory',
    owner  => $datadir_base_owner,
    group  => $datadir_base_group,
    mode   => '0755',
  }


  class { '::php::globals':
    php_version => '7.0',
    config_root => '/etc/php/7.0',
  }
  -> class { '::php':
    manage_repos => true,
    fpm          => true,
    dev          => $development_mode,
    composer     => true,
    pear         => true,
    phpunit      => $development_mode,
    settings     => $real_settings,
    extensions   => $real_extensions,
    #fpm_pools   => {},
  }






}
