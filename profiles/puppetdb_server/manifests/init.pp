# Class: puppetdb_server
############################
#
# Configuracion de Puppetdb

class puppetdb_server {
  class { 'puppetdb':
    listen_address    => '0.0.0.0',
    listen_port       => '8081',
    puppetdb_soft_write_failure=> true;
  }
  #class {'puppetdb::master::config': }


  #  firewall {
  #  '010 accept for localhost':
  #    source => 'localhost',
  #    proto  => 'tcp',
  #    action => 'accept',
  #  '021 puppetdb API vanaf knabbel':
  #    source =>  'puppetdb.upr.edu.cu',
  #    dport  =>  '8080',
  #    proto  =>  'tcp',
  #    action =>  'accept';
  #}

  # puppetboard profile
  #  class { '::puppetboardserver':}
}

