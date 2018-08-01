node /^mx\d+$/.upr\.edu\.cu$/ {
   class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    puppet_enabled => true,
    repos_enabled  => true,
    mta_enabled    => true,
  }

}


