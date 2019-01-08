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
  Boolean $enable_ssl                         = $::haproxy_serv::params::enable_ssl,
  Optional[Hash] $bind                        = $::haproxy_serv::params::bind,

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
    haproxy::listen { 'nginx' :
      collect_exported => $collect_exported,
      ipaddress        => $ipaddress,
      ports            => $ports,
      mode             => $mode,
    }
    haproxy::frontend { $listening_service :
      ipaddress => $ipaddress,
      ports     => $ports,
      mode      => $mode,
      options   => [
        { 'default_backend' => 'nginx_backend' },
        { 'timeout client'  => '30s' },
        { 'option'          => [
          'tcplog',
        ],
        }
      ],
      #bind      => {
      #  '*:80'  => ['ssl'],
      #  '*:443' => ['ssl'],
      #},
    }
    haproxy::backend { 'nginx_backend':
      mode    => 'http',
      options => {
        'option'  => [
          'tcplog',
        ],
        'balance' => 'roundrobin',
      },
}
  }
  class {'::haproxy_serv::balancemember':;}
}
