# Class: haproxy_serv::balancemember
# ===========================
#
# Full description of class haproxy_serv::balancemember here.
#
#
class haproxy_serv::balancemember (){
  each($::haproxy_serv::balancer_member) |Integer $index, String $value|{
    haproxy::balancermember { $::haproxy_serv::balancer_member[$index]:
    listening_service => $::haproxy_serv::listening_service,
    server_names      => $::haproxy_serv::server_names[$index],
    ipaddresses       => $::haproxy_serv::ipaddresses[$index],
    ports             => $::haproxy_serv::ports,
    options           => $::haproxy_serv::options,
  }
  }
}
