node 'gespro.upr.edu.cu'  {  
  class { '::basesys':
    uprinfo_usage  => 'servidor de gespro',
    application    => 'Gespro',
    puppet_enabled => true,
    repos_enabled  => false,
    mta_enabled    => false,
    puppet_users   => false,
  }
}
