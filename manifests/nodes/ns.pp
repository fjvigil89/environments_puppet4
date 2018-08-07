node /^ns\d+$/ {  
  class { '::basesys':
    uprinfo_usage  => 'servidor ns externo',
    application    => 'NS Externo',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
}
