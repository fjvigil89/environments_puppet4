node /^ceph\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor Ceph',
    application     => 'Debian Ceph',
    proxmox_enabled => false,
    repos_enabled   => true,
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
node /^test-ceph\d+$/ {
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor Ceph',
    application     => 'Debian Ceph',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => true,
  }
}

node 'test-ceph1.upr.edu.cu' {
  class {'ceph':
    mon_hosts   => [ 'test-ceph1.upr.edu.cu', 'test-ceph2.upr.edu.cu', 'test-ceph3.upr.edu.cu' ],
    release     => 'hammer',
    cluster_net => '192.168.2.0/28',
    public_net  => '10.2.2.0/24',
  }

 # class {'ceph::server::mon':
 #   id => 1
 # }
}
