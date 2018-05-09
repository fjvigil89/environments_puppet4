class gitlab {
	class { '::basesys':
    	uprinfo_usage  => 'test of puppet',
   	 application      => 'puppet',
    	puppet_enabled   => false;
  	}

	include gitlabserver

}
