node 'noc.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor NOC',
    application    => 'Noc Server UPR',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
