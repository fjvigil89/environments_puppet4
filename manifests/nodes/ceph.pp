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

 class { '::ceph':
    manage_repo => false,
    conf 	=> {
        'global'                => {
           'fsid'                      => '62ed9bd6-adf4-11e4-8fb5-3c970ebb2b86',
      	   'mon_initial_members'       => 'mon0',
           'mon_host'                  => '10.2.2.240',
           'public_network'            => '10.2.2.0/24',
           'cluster_network'           => '192.168.2.0/28',
           'auth_supported'            => 'cephx',
           'filestore_xattr_use_omap'  => true,
           'osd_crush_chooseleaf_type' => 0,
        },
       'mgr'                   => {
           'mgr modules' => 'dashboard',
        },
       'osd'                   => {
           'osd_journal_size' => 100,
        },
       'client.rgw.puppet'     => {
           'rgw frontends' => '"civetweb port=7480"'
        },
    },
 }
  
}
