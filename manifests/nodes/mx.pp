node /^mx\d+$/ {
  package { 'lsb-release':
	  ensure => installed,
  }
  #   class { '::basesys':
  #  uprinfo_usage  => 'servidor mx',
  #  application    => 'MX Postfix',
  #  puppet_enabled => false,
  #  repos_enabled  => false,
  #  mta_enabled    => false,
  #}

}


