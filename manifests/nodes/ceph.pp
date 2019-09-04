node 'text-ceph' {  
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor gestion',
    application     => 'Proxmox Gestion',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  }

 
  class {'ceph':
    mon_hosts   => [ 'text-ceph' ],
    release     => 'nautilus',
    cluster_net => '10.2.1.0/24',
    public_net  => '10.2.1.0/24',
  }

 /*
  class {'ceph::server::mon':
    id => 1
  }
*/



}
