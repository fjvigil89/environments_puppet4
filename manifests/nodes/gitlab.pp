node 'gitlab.upr.edu.cu'{
	#include gitlab

	class { '::basesys':
        	 uprinfo_usage  => 'servidor gitlab',
        	 application      => 'puppet',
        	 puppet_enabled   => false;
        }

        include gitlabserver
}
