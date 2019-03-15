node 'gespro.upr.edu.cu'  {  
  class { '::basesys':
    uprinfo_usage  => 'servidor de gespro',
    application    => 'Gespro',
    puppet_enabled => true,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
