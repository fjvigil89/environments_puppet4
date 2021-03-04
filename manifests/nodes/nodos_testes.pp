node /^test\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor de Desarrollo',
    application     => 'Proxmox Desarrollo',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
