node 'mx1.upr.edu.cu', 'mx2.upr.edu.cu', 'mx3.upr.edu.cu' {
  ###/^mx\d+$/
  package { 'lsb-release':
	  ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    #  puppet_enabled => false,
  #  repos_enabled  => false,
  #  mta_enabled    => false,
  }

}


