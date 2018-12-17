# Class: reverseProxy
# ===========================
# Copyright 2018 Your name here, unless otherwise noted.
#
class reverseProxy (
  Boolean $manage_repo                  = $::reverseProxy::params::manage_repo, 
  Optional[Array[Integer]] $listen_port = $::reverseProxy::params::listen_port,
  Optional[Array[Integer]] $ssl_port    = $::reverseProxy::params::ssl_port,
  Optional[Array[String]] $server_name  = $::reverseProxy::params::server_name,
)inherits ::reverseProxy::params{
  
  class {'::reverseProxy::common':;}
  class {'::reverseProxy::server':;}

}
