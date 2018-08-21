node 'firewall.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor firewall',
    application    => 'Firewall IPTABLES Server UPR',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
}

