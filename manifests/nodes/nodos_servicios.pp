node /^nodo\d+$/ { 
  include git
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor de Servicios',
    application     => 'Proxmox Servicios',
    proxmox_enabled => true,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => true,
  }
  #exec{"sysctl":
  #  command => '/usr/bin/sudo sysctl -w vm.max_map_count=262144',
  #}

  #class {'::filebeatserver':
  #  log_type => "syslog",
  #}
  #class {'::metricbeatserver':
  # modules  => ['system','ceph']
  #}

}
