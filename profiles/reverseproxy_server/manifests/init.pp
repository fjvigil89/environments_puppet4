# Copyright 2018 Your name here, unless otherwise noted.
#
class reverseproxy_server (
  Boolean $manage_repo                    = $::reverseProxy::params::manage_repo,
  Optional[Array[Integer]] $listen_port   = $::reverseProxy::params::listen_port,
  Optional[Array[Integer]] $ssl_port      = $::reverseProxy::params::ssl_port,
  Optional[Array[String]] $server_name    = $::reverseProxy::params::server_name,
  Optional[Array[String]] $location_allow = $::reverseProxy::params::location_allow,
)inherits ::reverseproxy_server::params{

  class {'::reverseproxy_server::common':;}
  class {'::reverseproxy_server::server':;}

}



