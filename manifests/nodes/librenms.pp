node 'libre.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor librenms',
    application    => 'LibreNMS',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
}
