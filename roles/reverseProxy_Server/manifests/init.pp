# Class: reverseProxy_Server
# ===========================
# Copyright 2018 Your name here, unless otherwise noted.
#
class reverseProxy_Server(
  Optional[Array[String]] $server_name  => undef,
  Optional[Array[Integer]] $listen_port => undef,
  Optional[Array[Integer]] $ssl_port    => undef,

) {

  class { '::basesys':
    uprinfo_usage   => 'servidor test',
    application     => 'puppet',    
    dmz             => true,
  }
 
  class { '::letsencrypt_host':
    dominios => $server_name,
  }

  class {'::reverseProxy':
    server_name => $server_name,
    listen_port => $listen_port,
    ssl_port    => $ssl_port,
  }



}
