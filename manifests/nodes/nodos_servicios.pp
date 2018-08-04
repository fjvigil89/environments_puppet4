node /^nodo\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }#~>
  #class { '::basesys':
  #  uprinfo_usage  => 'servidor de Servicios',
  #  application    => 'Proxmox Servicios',
  #  puppet_enabled => false,
  #  repos_enabled  => true,
  #  mta_enabled    => false,
  #}
}
