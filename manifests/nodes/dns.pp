node 'dns.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage  => 'servidor master dns',
    application    => 'DNS UPR',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
