node 'cvforestal.upr.edu.cu'  {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'Comunidad Virtual Forestal UPR',
    application    => 'Comunidad Virtual Forestal UPR',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
