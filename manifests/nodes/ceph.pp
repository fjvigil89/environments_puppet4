node 'text-ceph' {  
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor ceph',
    application     => 'Ceph',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  }

 

}
