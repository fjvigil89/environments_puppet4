node 'proxy-tor.upr.edu.cu','proxy-pap.upr.edu.cu' {  
   package { 'lsb-release':
          ensure => installed,
          }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor Proxy',
    application    => 'Servidor Proxy Squid',
    mta_enabled    => false,
  }
}

node 'proxy-go.upr.edu.cu'{
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'Servidor Proxy',
    application   => 'Servidor Proxy Squid',
    mta_enabled   => false,
    puppet_users  => false,
  }

}
