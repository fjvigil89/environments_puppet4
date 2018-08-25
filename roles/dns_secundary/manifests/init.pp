# Class: dns_secundary
# ===========================
####   
class dns_secundary (
 String $config_file            = $::dns_secundary::params::config_file,
 String $directory              = $::dns_secundary::params::directory,
 Array[String] $listen_on_addr  = $::dns_secundary::params::listen_on_addr,
 Array[String] $listen_on_v6_addr = $::dns_secundary::params::listen_on_v6_addr,
 Array[String] $forwarders      = $::dns_secundary::params::forwarders,
 Array[String] $allow_query     = $::dns_secundary::params::allow_query,
 String $dump_file              = $::dns_secundary::params::dump_file,
 String $statistics_file        = $::dns_secundary::params::statistics_file,
 String $memstatistics_file     = $::dns_secundary::params::memstatistics_file,
 # Array[String] $zone_name       = $::dns_secundary::params::zone_name,
 #Array[String] $file_zone_name  = $::dns_secundary::params::file_zone_name,
 #Array[String] $zone_reverse    = $::dns_secundary::params::zone_reverse,
 #String $zone_type              = $::dns_secundary::params::zone_type,

)inherits ::dns_secundary::params {

 class { '::basesys':
    uprinfo_usage  => 'servidor dns cache',
    application    => 'DNS Bind9',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
    dns_enabled    => false,
  }
  #class {'bind_server':;}
  class {'::dns_secundary::cache':;}

}

