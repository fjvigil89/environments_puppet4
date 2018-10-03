node /^nodo\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor de Servicios',
    application     => 'Proxmox Servicios',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
