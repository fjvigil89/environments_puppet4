node 'graphite.upr.edu.cu'{
class { '::basesys':
  ¦ uprinfo_usage  => 'graphite_server',
  ¦ application    => 'graphite',
  ¦ puppet_enabled => false,
  ¦ mta_enabled    => false,
  }
}
