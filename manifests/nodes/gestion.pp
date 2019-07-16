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

  exec{"sysctl":
    command => '/usr/bin/sudo sysctl -w vm.max_map_count=262144',
  }

  class {'::filebeatserver':
    log_type => "syslog",
  }
  class {'::metricbeatserver':
   modules  => ['system','ceph']
  }

}
