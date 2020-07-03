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

    class { 'ceph':
      fsid                       => generate('/usr/bin/uuidgen'),
      mon_host                   => $::ipaddress,
      authentication_type        => 'none',
      osd_pool_default_size      => '1',
      osd_pool_default_min_size  => '1',
    }
    ceph_config {
     'global/osd_journal_size': value => '100';
    }
    ceph::mon { 'a':
      public_addr         => $::ipaddress,
      authentication_type => 'none',
    }
    ceph::osd { '/dev/sdb': } 
}
