# Class: dns_secundary
# ===========================
####   
class dns_secundary (
 String $config_file            = $::dns_secundary::params::config_file,
 Array[String] $listen_on_addr  = $::dns_secundary::params::listen_on_addr,
 Array[String] $listen_on_v6_addr = $::dns_secundary::params::listen_on_v6_addr,
 Array[String] $forwarders      = $::dns_secundary::params::forwarders,
 Array[String] $allow_query     = $::dns_secundary::params::allow_query,
 Array[String] $zone_name       = $::dns_secundary::params::zone_name,
 Array[String] $zone_reverse    = $::dns_secundary::params::zone_reverse,
 String $zone_type              = $::dns_secundary::params::zone_type,

)inherits ::dns_secundary::params {

  include dns_bind~>
  class {'::dns_secundary::cache':;}

}

