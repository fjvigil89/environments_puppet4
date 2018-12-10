# Class: dns_primary
# ===========================
#
#
class dns_primary (
 String $config_file            	  = $::dns_primary::params::config_file,
 String $directory              	  = $::dns_primary::params::directory,
 Optional[String] $recursion        = $::dns_primary::params::recursion,
 Array[String] $listen_on_addr  	  = $::dns_primary::params::listen_on_addr,
 Array[String] $listen_on_v6_addr 	= $::dns_primary::params::listen_on_v6_addr,
 Array[String] $forwarders      	  = $::dns_primary::params::forwarders,
 Boolean $forward               	  = $::dns_primary::params::forward,
 Boolean $slave                     = false,
 Optional[String] $allow_query     	= $::dns_primary::params::allow_query,
 Array[String] $allow_transfer      = $::dns_primary::params::allow_transfer,
 String $dump_file              	  = $::dns_primary::params::dump_file,
 String $statistics_file        	  = $::dns_primary::params::statistics_file,
 String $memstatistics_file     	  = $::dns_primary::params::memstatistics_file,
 Array[String] $zone_name       	  = $::dns_primary::params::zone_name,
 Array[String] $file_zone_name  	  = $::dns_primary::params::file_zone_name,
 Array[String] $zone_reverse    	  = $::dns_primary::params::zone_reverse,
 String $mymaster                   = $::dns_primary::params::mymasters,
 String $zone_type              	  = $::dns_primary::params::zone_type,
 Optional[Hash] $zones              = $::dns_primary::params::zones,
 Optional[Hash] $views			        = $::dns_primary::params::views,
)inherits ::dns_primary::params{

  class {'bind':;}~>class {'::dns_primary::primary':;}

}
