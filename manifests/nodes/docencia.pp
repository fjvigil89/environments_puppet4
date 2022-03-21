node /^docencia\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor docencia',
    application     => 'Proxmox Docencia',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
