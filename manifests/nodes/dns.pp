node 'dns.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor dns',
    application    => 'DNS Bind9',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }

}
