node 'gitlab.upr.edu.cu'{
	#include gitlab

	#class { '::basesys':
       # 	 uprinfo_usage  => 'servidor gitlab',
       # 	 application      => 'puppet',
       # 	 puppet_enabled   => false;
       # }

        include gitlabserver
  # To install puppet-lint
  package { 'puppet-lint':
  ensure   => '1.1.0',
  provider => 'gem',
  }

}
