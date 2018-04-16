# Class: puppetdb_server
############################
#
# Configuracion de Puppetdb

class puppetdb_server {
  class { '::puppetdb':
    listen_address   => '0.0.0.0',
    listen_port      => '8001',
    open_listen_port => true,
  }
}

