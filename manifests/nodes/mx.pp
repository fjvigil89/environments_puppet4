node /^mx\d+$/ {
   class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    # puppet_enabled => false,
    #repos_enabled  => false,
    #mta_enabled    => false,
  }

}


