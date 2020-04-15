# Class: reverse_proxy_server
# ===========================
#
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class reverse_proxy_server (
  Optional[Array[String]] $server_name  = undef,
  Optional[Array[String]] $location_allow = undef,
  Optional[Array[Integer]] $listen_port = undef,
  Optional[Array[Integer]] $ssl_port    = undef,
) {
  class { '::basesys':
    uprinfo_usage   => 'servidor test',
    application     => 'puppet',
    dmz             => true,
  }

  #class { '::letsencrypt_host':
  #  dominios => $server_name,
  #  }->
  class { '::reverseproxy_server':
    manage_repo    => false,
    server_name    => $server_name,
    listen_port    => $listen_port,
    ssl_port       => $ssl_port,
    location_allow => $location_allow,
  }


}
