# Class: haproxy_serv::balancemember
# ===========================
#
# Full description of class haproxy_serv::balancemember here.
#
#
class haproxy_serv::balancemember (){
  each($::haproxy_serv::params::balancer_member) |Integer $index, String $value|{
    haproxy::balancermember { $::haproxy_serv::params::balancer_member[$index]:
    listening_service => $::haproxy_serv::params::listening_service,
    server_names      => $::haproxy::params::server_names[$index],
    ipaddresses       => $::haproxy::params::ipaddresses[$index],
    ports             => $::haproxy::params::ports[$index],
    options           => $::haproxy::params::options,
  }
  }
}
