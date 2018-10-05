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
  class {'::talkserver::prosody':;}
  class {'::talkserver::package':;}
  class {'::talkserver::config':;}
  class {'::talkserver::service':;}
  # class {'::talkserver::user_admin':;}
  class {'::talkserver::community_modules':;}
  # class {'::talkserver::virtualhost':;}

}
talkserver::virtualhost {
    'upr.edu.cu' :
      ensure   => present,
      ssl_key  => '/etc/ssl/key/mydomain.com.key',
      ssl_cert => '/etc/ssl/crt/mydomain.com.crt',
  }

  talkserver::user { 'admin':
    host => 'mydomain.com',
    pass => 'itsasecret',
  }

#Fin del jabber
