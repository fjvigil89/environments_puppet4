node 'client-puppet.upr.edu.cu'{
  #include ::puppetdevserver
  class { '::basesys':
        uprinfo_usage =>  'Puppet dev server',
            application =>  'puppetserver',
                application_tier =>  'dev',
                    puppet_enabled =>  false;
                    }
}
