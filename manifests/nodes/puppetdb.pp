node 'puppetdb.upr.edu.cu' {
  #include puppetdb_server
  # include ntp
  #class puppetdb_server {
      class { 'puppetdb':
        listen_address =>  '0.0.0.0',
        manage_firewall =>  true,
      }
      # }
}
