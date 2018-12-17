# Class: reverseProxyServer
# ===========================
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class reverseProxyServer(
  Optional[Array[String]] $server_name  = undef,
  Optional[Array[Integer]] $listen_port = undef,
  Optional[Array[Integer]] $ssl_port    = undef,


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
