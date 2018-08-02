node 'mx1.upr.edu.cu' {
  ###/^mx\d+$/
  package { 'lsb-release':
	  ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => true,
  }

}
node 'mx2.upr.edu.cu' {
  package { 'lsb-release':
    ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => true,
  }

}
node 'mx3.upr.edu.cu' {
  package { 'lsb-release':
    ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => true,
  }

}



