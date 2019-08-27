node 'puppet-new.upr.edu.cu'{
  class { 'prosody':
    user              => 'prosody',
    group             => 'prosody',
    community_modules => 'mod_auth_ldap',
    authentication    => 'ldap',
    custom_options    => {
                            'ldap_base'     => 'DC="upr",DC="edu",DC="cu"',
                            'ldap_server'   => '10.2.4.35:636',
                            'ldap_rootdn'   => 'CN="talk",OU="_Servicios",DC="upr",DC="edu",DC="cu"',
                            'ldap_password' => '40a*talk.2k12',
                            'ldap_scope'    => 'subtree',
                            'ldap_tls'      => 'true',
                          },
  }

  /* prosody::virtualhost {
    'mydomain.com' :
      ensure   => present,
      ssl_key  => '/etc/ssl/key/mydomain.com.key',
      ssl_cert => '/etc/ssl/crt/mydomain.com.crt',
  }

  prosody::user { 'foo':
    host => 'mydomain.com',
    pass => 'itsasecret',
  } */
  /* include puppetdevserver
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
#    uprinfo_usage   => 'servidor puppet-new',
#    application     => 'Prueba',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  } */
}
