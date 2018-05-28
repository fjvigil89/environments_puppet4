# == Class: talkserver
#
# Full description of class talkserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'talkserver':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class talkserver {

#inicio del jabbel
class { 'prosody':
    user              => 'prosody',
    group             => 'prosody',
    community_modules => ['mod_auth_ldap'],
    authentication    => 'ldap',
    custom_options    => {
                            'ldap_base'     => '"DC=upr,DC=edu,DC=cu"',
                            'ldap_server'   => '"ad.upr.edu.cu:636"',
                            'ldap_rootdn'   => '"DN=talk,OU=_Servicios,DC=upr,DC=edu,DC=cu"',
                            'ldap_password' => '"40a*talk.2k12"',
                            'ldap_scope'    => '"subtree"',
                            'ldap_tls'      => 'false',
                          },
  }

  prosody::virtualhost {
    'sync.upr.edu.cu' :
      ensure   => present,
      #ssl_key  => '/etc/ssl/key/sync.upr.edu.cu.key',
      #ssl_cert => '/etc/ssl/crt/sync.upr.edu.cu.crt',
  }

#fin del jabbel



}
