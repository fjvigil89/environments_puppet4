# == Class: talkserver
#
# Full description of class talkserver here.
#
#Inicio del jabber

class talkserver (
  String $user            = $::talkserver::params::user,
  String $group           = $::talkserver::params::group,
  String $authentication  = $::talkserver::params::authentication,
  String $ldap_base       = $::talkserver::params::ldap_base,
  String $ldap_server     = $::talkserver::params::ldap_server,
  String $ldap_rootdn     = $::talkserver::params::ldap_rootdn,
  String $ldap_password   = $::talkserver::params::ldap_password,
  String $admins          = $::talkserver::params::admins,
  String $pidfile         = $::talkserver::params::pidfile,
  String $log_level       = $::talkserver::params::log_level,
  String $info_log        = $::talkserver::params::info_log,
  String $error_log       = $::talkserver::params::error_log,
  String $log_sinks       = $::talkserver::params::log_sinks,
  Boolean $use_libevent   = $::talkserver::params::use_libevent,
)
inherits talkserver::params {
class { 'prosody':
  user              => $user,
  group             => $group,
  community_modules => ['mod_auth_ldap'],
  authentication    => $authentication,
  custom_options    => {
    'ldap_base'     => $ldap_base,
    'ldap_server'   => $ldap_server,
    'ldap_rootdn'   => $ldap_rootdn,
    'ldap_password' => $ldap_password,
    'ldap_scope'    => 'subtree',
    'ldap_tls'      => 'false',
  },
}

prosody::virtualhost {
  'upr.edu.cu' :
    ensure   => present,
#ssl_key  => '/etc/ssl/key/sync.upr.edu.cu.key',
#ssl_cert => '/etc/ssl/crt/sync.upr.edu.cu.crt',
}

prosody::user { 'admin':
  host => 'upr.edu.cu',
  pass => 'admin',
  }
}

class { 'prosody::package': }
class { 'prosody::config': }
class { 'prosody::service': }

#Fin del jabber
