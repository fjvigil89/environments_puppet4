node 'noc.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor NOC',
    application    => 'Noc Server UPR',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
}
