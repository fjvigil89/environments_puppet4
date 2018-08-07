node 'stack.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor Stack',
    application    => 'Stack Solution',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
