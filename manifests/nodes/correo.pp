node 'correo-prof.upr.edu.cu', 'correo-profe.upr.edu.cu'  {  
  class { '::basesys':
    uprinfo_usage  => 'servidor correo profesores fisico',
    application    => 'Zimbra',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}

node 'correo-est.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage  => 'servidor correo est KVM',
    application    => 'Zimbra',
    puppet_enabled => true,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
