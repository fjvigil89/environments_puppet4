node /^gestion\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor gestion',
    application     => 'Proxmox Gestion',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
