node 'wh-apache.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor wh-apache',
    application    => 'wh-apache',
    puppet_enabled => false,
    mta_enabled    => false,
  }
}
