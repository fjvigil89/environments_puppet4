#$puppetdb_host = 'puppetdb.upr.edu.cu'
node 'puppet-master.upr.edu.cu' {
  class { 'puppetdb': 
   listen_address   =>  '0.0.0.0',
  }
    class { 'puppetdb::master::config': }
  #class {'puppetdb::master::config':
  #puppetdb_server => $puppetdb_host,
  #}


}
