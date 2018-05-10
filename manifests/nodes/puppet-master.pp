node 'puppet-master.upr.edu.cu' {

class { 'puppetdb': 
  listen_address   =>  '0.0.0.0',
}
  class { 'puppetdb::master::config': }
  
  include puppetboardserver
  
 # To install puppet-lint
  package { 'puppet-lint':
  ensure   => '1.1.0',
  provider => 'gem',
  }
}
