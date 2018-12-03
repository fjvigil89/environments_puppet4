node 'nasdev.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor NasDev',
    application     => 'NasDev',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
