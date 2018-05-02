#$puppetdb_host = 'puppetdb.upr.edu.cu'
node 'puppet-master.upr.edu.cu' {
  include ::puppetdb_server
  #class {'puppetdb::master::config':
  #puppetdb_server => $puppetdb_host,
  #}


}
