node 'proxy-go.upr.edu.cu','proxy-tor.upr.edu.cu','proxy-pap.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'Servidor Proxy',
    application    => 'Servidor Proxy Squid',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
