node /^dev+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor Desarrollo',
    application     => 'Proxmox Dev',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
