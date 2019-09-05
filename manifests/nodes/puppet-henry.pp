node 'puppet-henry.upr.edu.cu' {
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'Server Prosody',
    application   => 'Prosody',
    repos_enabled => true,
    mta_enabled   => false,
  }
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
                            'ldap_tls'      => true,
                          },
  }
}
