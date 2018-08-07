node 'dhcp.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor DHCP UPR',
    application    => 'DHCP',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
