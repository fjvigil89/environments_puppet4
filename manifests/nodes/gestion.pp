node /^gestion\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor gestion',
    application    => 'Proxmox Gestion',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
