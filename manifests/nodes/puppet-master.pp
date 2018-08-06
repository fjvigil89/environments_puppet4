node 'puppet-master.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage  => 'servidor test',
    application    => 'puppet',
    puppet_enabled => false,
    repos_enabled  => false,
  }

  class { 'puppetdb':
  listen_address          => '0.0.0.0',
  }
  class { 'puppetdb::master::config': 
    manage_report_processor => true,
    enable_reports          => true,
  }
  
  include puppetboardserver
  
  #To install puppet-lint
  package { 'puppet-lint':
  ensure                  => '1.1.0',
  provider                => 'gem',
  }
}
