node 'ntp.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor ntp',
    application    => 'NTP Service',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
    time_enabled   => false,
  }
}
