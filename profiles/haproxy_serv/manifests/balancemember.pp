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
    server_names      => $::haproxy::server_names[$index],
    ipaddresses       => $::haproxy::ipaddresses[$index],
    ports             => $::haproxy::ports[$index],
    options           => $::haproxy::options,
  }
  }
}
