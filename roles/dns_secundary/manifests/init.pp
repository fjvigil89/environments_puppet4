# Class: dns_secundary
# ===========================
####   
<<<<<<< HEAD
class dns_secundary {
include bind
bind::server::conf { '/etc/named.conf':
listen_on_addr => ['10.2.1.13','localhost'],
  directory      => '/var/cache/bind',
  recursion      => 'yes',
  forwarders     => [ '10.2.1.8' ],
  allow_query    => [ '10.2.0.0/15' ],
}
=======
class dns_secundary (
 String $config_file            = $::dns_secundary::params::config_file,
 String $directory              = $::dns_secundary::params::directory,
 Array[String] $listen_on_addr  = $::dns_secundary::params::listen_on_addr,
 Array[String] $listen_on_v6_addr = $::dns_secundary::params::listen_on_v6_addr,
 Array[String] $forwarders      = $::dns_secundary::params::forwarders,
 Boolean $forward      = $::dns_secundary::params::forward,
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
  class {'bind':;}~>class {'::dns_secundary::cache':;}

>>>>>>> production
}

