# Class: squid_server::base
# ===========================
#
#
class squid_server::base
{ 
  class { 'squid':
    http_access => $::squid_server::http_access,
    http_ports  => $::squid_server::http_ports,
    https_ports => $::squid_server::https_ports,
    icp_access  => $::squid_server::icp_access,
    icp_port    => $::squid_server::icp_port,
  }


}
