node 'masterkube.upr.edu.cu'{  
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor Ceph',
    application     => 'Debian Ceph',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => false,
    proxy_enabled   => true,
    proxy_url       => 'http://proxy-tor.upr.edu.cu',
  }

  class {'kubernetes':
    controller => true,
  }
}
node 'workerkube.upr.edu.cu'{    
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor Ceph',
    application     => 'Debian Ceph',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => false,
    proxy_enabled   => true,
    proxy_url       => 'http://proxy-tor.upr.edu.cu',
  }
  
  class {'kubernetes':
    worker => true,
  }
}


