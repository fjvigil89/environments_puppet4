# Class: haproxy_serv
# ===========================
#
# Full description of class haproxy_serv here.
#
#
class haproxy_serv (
  #Haproxy Listn parametes
  Optional[Boolean] $collect_exported   = $::haproxy_serv::params::collect_exported,
  String $ipaddress                     = $::haproxy_serv::params::address,
  Optional[Hash] $listen_options        = $::haproxy_serv::params::listen_options,
  #Balancer Member parameters
  String $listening_service             = $::haproxy_serv::params::listening_service,
  Array[String] $balancer_member        = $::haproxy_serv::params::balancer_member,
  Optional[Array[String]] $server_names = $::haproxy_serv::params::server_names,
  Array[String] $ipaddresses            = $::haproxy_serv::params::ipaddresses,
  Array[String] $ports                  = $::haproxy_serv::params::ports,
  Optional[String] $options             = $::haproxy_serv::params::options,

) inherits haproxy_serv::params {
  include haproxy
  haproxy::listen { $listening_service :
    collect_exported => $collect_exported,
    ipaddress        => $ipaddress,
    ports            => $ports,
  }
  class {'::haproxy_serv::balancemember':;}
}
