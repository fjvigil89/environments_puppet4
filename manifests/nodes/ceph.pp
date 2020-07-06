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
    $admin_key = 'AQCTg71RsNIHORAAW+O6FCMZWBjmVfMIPk3MhQ=='
    $mon_key = 'AQDesGZSsC7KJBAAw+W/Z4eGSQGAIbxWjxjvfw=='
    $bootstrap_osd_key = 'AQABsWZSgEDmJhAAkAGSOOAJwrMHrM5Pz5On1A=='
    $fsid = '066F558C-6789-4A93-AAF1-5AF1BA01A3AD'
 node /^test-ceph\d+$/ {
      class { 'ceph':
        fsid                => $fsid,
        mon_initial_members => 'test-ceph1.upr.edu.cu,test-ceph2.upr.edu.cu,test-ceph3.upr.edu.cu',
        mon_host            => '10.2.2.240,10.2.2.241,10.2.2.242',
      }
      ceph::mon { $::hostname:
        key => $mon_key,
      }
      Ceph::Key {
        inject         => true,
        inject_as_id   => 'mon.',
        inject_keyring => "/var/lib/ceph/mon/ceph-${::hostname}/keyring",
      }
      ceph::key { 'client.admin':
        secret  => $admin_key,
        cap_mon => 'allow *',
        cap_osd => 'allow *',
        cap_mds => 'allow',
      }
      ceph::key { 'client.bootstrap-osd':
        secret  => $bootstrap_osd_key,
        cap_mon => 'allow profile bootstrap-osd',
      }

      # ceph::osd { '/dev/sdb': }

      ceph::key {'client.bootstrap-osds':
         keyring_path => '/var/lib/ceph/bootstrap-osd/ceph.keyring',
         secret       => $bootstrap_osd_key,
      }
 }

 node 'test-ceph1.upr.edu.cu'{
  
   class { 'ceph':
        fsid                => $fsid,
        mon_initial_members => 'test-ceph1.upr.edu.cu,test-ceph2.upr.edu.cu,test-ceph3.upr.edu.cu',
        mon_host            => '10.2.2.240,10.2.2.241,10.2.2.242',
      }

   ceph::osd { '/dev/sdb': }

   ceph::key { 'client.admin':
        secret => $admin_key
      }
}

