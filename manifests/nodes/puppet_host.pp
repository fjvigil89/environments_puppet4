node 'client-puppet.upr.edu.cu'{

class { '::basesys':
         uprinfo_usage  => 'servidor gitlab',
         application      => 'puppet',
         puppet_enabled   => false;
        }

        include gitlabserver

}
