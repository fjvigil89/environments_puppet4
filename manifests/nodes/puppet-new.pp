node 'puppet-new.upr.edu.cu' {  
  include puppetserver
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor puppet-new',
    application     => 'Prueba',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
