node 'intranet.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor intranet',
    application    => 'Intranet',
    puppet_enabled => false,
    mta_enabled    => false,
  }
}
