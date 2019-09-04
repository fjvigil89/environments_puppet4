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
    release     => 'hammer',
    cluster_net => '1.2.1.0/24',
    public_net  => '1.2.4.0/23',
  }

  #class {'ceph::server::mon':
  #  id => 1
  #}




}
