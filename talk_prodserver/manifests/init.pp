# Class: talk_prodserver
# ===========================
#
# Full description of class talk_prodserver here.

#class talk_prodserver(){
#package { 'lsb-release':
#  ensure => installed,
#}~>

class {'::basesys':
uprinfo_usage => 'Servidor jabber',
application   => 'Production',
mta_enabled   => false,
}

class { '::talkserver':
  user           => $::talkserver::params::user,
  group          => $::talkserver::params::group,
  authentication => $::talkserver::params::authentication,
  ldap_base      => $::talkserver::params::ldap_base,
  ldap_server    => $::talkserver::params::ldap_server,
  ldap_rootdn    => $::talkserver::params::ldap_rootdn,
  ldap_password  => $::talkserver::params::ldap_password,
  admins         => $::talkserver::params::admins,
  pidfile        => $::talkserver::params::pidfile,
  log_level      => $::talkserver::params::log_level,
  info_log       => $::talkserver::params::info_log,
  error_log      => $::talkserver::params::error_log,
  log_sinks      => $::talkserver::params::log_sinks,
  use_libevent   => $::talkserver::params::use_libevent,
}
