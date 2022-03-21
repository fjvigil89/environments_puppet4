node /^ntp\d+$/{  
  class { '::basesys':
    uprinfo_usage  => 'servidor ntp',
    application    => 'NTP Server ',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
    time_enabled   => false,
    dns_preinstall => true,
  }
}
