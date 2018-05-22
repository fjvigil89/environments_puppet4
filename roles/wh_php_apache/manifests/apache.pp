 # == Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache::apache{

 class { 'apache':
  default_vhost => true,
  mpm_module => 'prefork',
 }

  # Load mod_rewrite if needed and not yet loaded
  if ! defined(Class['apache::mod::rewrite']) {
  ¦ include ::apache::mod::rewrite
  }

  class { '::apache::mod::proxy':; }
  -> class { '::apache::mod::proxy_fcgi':; }

  if $mod_security_enabled {
  ¦ class { '::apache::mod::security':
  ¦ ¦ activated_rules      => $mod_security_rules,
  ¦ ¦ modsec_secruleengine => $mod_security_mode,

  ¦ }
  } 

}
