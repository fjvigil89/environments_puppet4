# Class: squid_server
# ===========================
#
#
class squid_server(
  Optional[Hash] $http_access  = $::squid_server::params::http_access,
  Optional[Hash] $http_ports  = $::squid_server::params::http_ports,
  Optional[Hash] $https_ports  = $::squid_server::params::https_ports,
  Optional[Hash] $icp_access  = $::squid_server::params::icp_access,
  Optional[Hash] $icp_port  = $::squid_server::params::icp_port,
)inherits ::squid_server::params{
  
  class {'::squid_server::base':;}
  class {'::squid_server::common':;}

}
