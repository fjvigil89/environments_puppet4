node /^(master|worker)\kube\d+$/{  
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
}



