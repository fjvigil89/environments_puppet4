node 'puppetdb.upr.edu.cu' {
  #include puppetdb_server
  # include ntp
  #class puppetdb_server {
      class { 'puppetdb':
        listen_address   => '0.0.0.0',
        listen_port      => '8001',
        open_listen_port => true,
      }
      class {'puppetdb::master::config': }
      # }
}
