# Class: haproxy_serv
# ===========================
#
# Full description of class haproxy_serv here.
#
#
class haproxy_serv (
  #Haproxy Listn parametes
  Optional[Boolean] $collect_exported         = $::haproxy_serv::params::collect_exported,
  String $ipaddress                           = $::haproxy_serv::params::address,
  Optional[Hash] $listen_options              = $::haproxy_serv::params::listen_options,
  Optional[Enum['tcp','http','health']] $mode = 'http',
  #Balancer Member parameters
  String $listening_service                   = $::haproxy_serv::params::listening_service,
  Array[String] $balancer_member              = $::haproxy_serv::params::balancer_member,
  Array[String] $server_names                 = $::haproxy_serv::params::server_names,
  Array[String] $ipaddresses                  = $::haproxy_serv::params::ipaddresses,
  Array[String] $ports                        = $::haproxy_serv::params::ports,
  Optional[String] $options                   = $::haproxy_serv::params::options,
  # enable_ssl= true when using frontend & backend
  Optional[Array[String]] $frontend_name      = $::haproxy_serv::params::frontend_name,
  Optional[Array[String]] $backend_names      = $::haproxy_serv::params::backend_names,
  Optional[Hash] $frontend_options            = $::haproxy_serv::params::frontend_options,
  Optional[Hash] $backend_options             = $::haproxy_serv::params::backend_options,
  Optional[Enum['tcp','http','health']] $frontend_mode = 'http',
  Optional[Enum['tcp','http','health']] $backend_mode = 'http',
  Boolean $enable_ssl                         = $::haproxy_serv::params::enable_ssl,
  Optional[Hash] $bind                        = $::haproxy_serv::params::bind,
  Optional[Boolean] $stats                    = $::haproxy_serv::params::stats,
) inherits haproxy_serv::params {
  include haproxy
  if($enable_ssl == false){
  haproxy::listen { $listening_service :
    collect_exported => $collect_exported,
    ipaddress        => $ipaddress,
    ports            => $ports,
    mode             => $mode,
  }
  }
  else {
    #haproxy::listen { $listening_service :
    #  collect_exported => $collect_exported,
    #  ipaddress        => $ipaddress,
    #  ports            => $ports,
    #  mode             => $mode,
    #}
    #haproxy::frontend { 'nginx_server' :
    #  mode      => $frontend_mode,
    #  options   => $frontend_options,
    #  bind      => $bind,
    #}
    #class {'::haproxy_serv::backend':;}
  }
  class {'::haproxy_serv::balancemember':;}
  if($stats){
    haproxy::listen { 'stats':
      order     => '30',
      ipaddress => $ipaddress,
      ports     => '9090',
      options   => {
        'mode'  => 'http',
        'stats' => [
          'uri /',
          'auth stats:haproxy',
        ],
      },
    }
  }
}
