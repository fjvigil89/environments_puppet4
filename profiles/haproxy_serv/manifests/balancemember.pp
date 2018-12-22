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
    #server_names     => $::haproxy::params::server_names[$index],
    server_names      => ['nginx01.upr.edu.cu','nginx02.upr.edu.cu'],
    #ipaddresses      => $::haproxy::params::ipaddresses[$index],
    ipaddresses       => ['10.2.1.77','10.2.1.79'],
    #ports            => $::haproxy::params::ports[$index],
    ports             => ['80'],
    options           => $::haproxy::params::options,
  }
  }
}
