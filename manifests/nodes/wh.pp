node 'wh.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor wh',
    application    => 'wh',
    puppet_enabled => false,
    mta_enabled    => false,
  }
}
