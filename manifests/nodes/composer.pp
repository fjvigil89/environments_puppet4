node 'composer.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor Composer',
    application    => 'Composer',
    puppet_enabled => false,
    mta_enabled    => false,
	dmz            => true,
  }
}
