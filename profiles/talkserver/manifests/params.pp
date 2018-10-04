# == Class: talkserver::params
#
# Full description of class talkserver::params here.

class talkserver::params{
  $admins            = []
  $pidfile           = '/var/run/prosody/prosody.pid'
  $log_level         = 'info'
  $info_log          = '/var/log/prosody/prosody.log'
  $error_log         = '/var/log/prosody/prosody.err'
  $log_sinks         = ['syslog']
  $use_libevent      = true
  $user              = 'prosody'
  $group             = 'prosody'
  $authentication    = 'ldap'
  $ldap_base         = '"OU=_Servicios,DC=upr,DC=edu,DC=cu"'
  $ldap_server       = '"ad.upr.edu.cu:636"'
  $ldap_rootdn       = '"DN=prosody,OU=_Servicios,DC=upr,DC=edu,DC=cu"'
  $ldap_password     = '"40a*talk.2k12"'
}
