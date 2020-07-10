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

}
#$admin_key = 'AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFR8x2v5r4arPvuCp+oPF2fTCZZMgWayP1Pvwnu32kdF0V77D20GaqlDA7JykwZDck5iORc/HL7xlG55x5vVYmw='
#$mon_key = 'AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIXwMZ/b9V8vMgvsh9kjEeOY6F/j1rEgiRhRUi+OSVW/uUEHnLxfwaotbSuO1bulq372YgPJL1beOOgCJeT6M7w='
#$bootstrap_osd_key = 'AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFR8x2v5r4arPvuCp+oPF2fTCZZMgWayP1Pvwnu32kdF0V77D20GaqlDA7JykwZDck5iORc/HL7xlG55x5vVYmw='
#$fsid = '066F558C-6789-4A93-AAF1-5AF1BA01A3AD'

    $admin_key = 'AQCTg71RsNIHORAAW+O6FCMZWBjmVfMIPk3MhQ=='
    $mon_key = 'AQDesGZSsC7KJBAAw+W/Z4eGSQGAIbxWjxjvfw=='
    $bootstrap_osd_key = 'AQABsWZSgEDmJhAAkAGSOOAJwrMHrM5Pz5On1A=='
    $fsid = '066F558C-6789-4A93-AAF1-5AF1BA01A3AD'
 node /^test-ceph\d+$/ {

   class { 'ceph':
        fsid                => $fsid,
        mon_initial_members => 'test-ceph1.upr.edu.cu,test-ceph2.upr.edu.cu,test-ceph3.upr.edu.cu',
        mon_host            => '10.2.2.240,10.2.2.241,10.2.2.242',
        cluster_network     => '192.168.2.0/28',
        public_network      => '10.2.2.0/24',
      }
      ceph_config {
       'global/osd_journal_size': value => '100';
      }
      ceph::mon { 'a':
        public_addr         => $::ipaddress,
        authentication_type => 'none',
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

      #ceph::osd { '/dev/sdb': }
      #ceph::osd {
      #'/dev/sdb':
      #  journal => 'nfs';
      #'/dev/sdb1':
      #  journal => 'nfs';
      #}

      #ceph::key {'client.bootstrap-osds':
      #   keyring_path => '/var/lib/ceph/bootstrap-osds/ceph.keyring',
      #   secret       => $bootstrap_osd_key,
      #}

 }



