$puppetdb_host = 'puppetdb.upr.edu.cu'
node 'puppet-master.upr.edu.cu' {
  class {'puppetdb::master::config':
  puppetdb_server => $puppetdb_host,
  }
}
