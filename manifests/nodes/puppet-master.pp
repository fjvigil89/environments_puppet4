node 'puppet-master.upr.edu.cu' {

class { 'puppetdb': 
   listen_address   =>  '0.0.0.0',
  }
  class { 'puppetdb::master::config': }

  include puppetboardserver
}
