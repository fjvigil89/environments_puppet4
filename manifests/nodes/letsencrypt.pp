node 'letscert.upr.edu.cu' {  
    class { '::basesys':
    uprinfo_usage  => 'Servidor lets encrypt',
    application    => 'lets encrypt',
    mta_enabled    => false,
  }
}
