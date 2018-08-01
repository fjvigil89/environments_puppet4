node /^mx\d+$/ {
   class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    puppet_enabled => true,
    repos_enabled  => false,
    mta_enabled    => true,
  }

}


