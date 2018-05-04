node 'puppet-master.upr.edu.cu' {
 class { '::basesys':
    uprinfo_usage  => 'puppet master',
    application      => 'puppet-master',
    puppet_enabled   => false;
  }

class { 'puppetdb': 
   listen_address   =>  '0.0.0.0',
  }
  class { 'puppetdb::master::config': }

  include puppetboardserver
}
