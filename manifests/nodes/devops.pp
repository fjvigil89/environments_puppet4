node /^devops\d+$/  {  
  include git
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor de Servicios Devops',
    application     => 'Proxmox Servicios',
    proxmox_enabled => true,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => true,
    puppet_enabled  => true,
  }
  exec{"sysctl":
    command => '/usr/bin/sudo sysctl -w vm.max_map_count=262144',
  }

}
