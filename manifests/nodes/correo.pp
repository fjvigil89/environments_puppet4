node 'correo-profe.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor correo fisico',
    application    => 'Zimbra',
    puppet_enabled => true,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
