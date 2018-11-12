#Clase talkserver::prosody

class talkserver::prosody (){

  class { 'prosody':
  user              => $talkserver::user,
  group             => $talkserver::group,
  community_modules => ['mod_auth_ldap'],
  authentication    => $talkserver::authentication,
  admins            => $talkserver::admins,
  pidfile           => $talkserver::pidfile,
  log_level         => $talkserver::log_level,
  info_log          => $talkserver::info_log,
  error_log         => $talkserver::error_log,
  log_sinks         => $talkserver::log_sinks,
  use_libevent      => $talkserver::use_libevent,
  custom_options    => {
    'ldap_base'     => $talkserver::ldap_base,
    'ldap_server'   => $talkserver::ldap_server,
    'ldap_rootdn'   => $talkserver::ldap_rootdn,
    'ldap_password' => $talkserver::ldap_password,
    'ldap_scope'    => 'subtree',
    'ldap_tls'      => 'false',
  },
}
}
