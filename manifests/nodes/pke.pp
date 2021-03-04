node 'pke.upr.edu.cu' {  
  
 class { '::basesys':
    uprinfo_usage   => 'servidor PKE',
    application     => 'Instalation PKE',
    repos_enabled   => true,
    mta_enabled     => false,
  }

 class {'::pkeserver':;}
}

