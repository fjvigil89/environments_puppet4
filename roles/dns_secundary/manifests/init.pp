# Class: dns_secundary
# ===========================
####   
class dns_secundary (
  String $config_file              = $::dns_secundary::params::config_file,
  String $directory                = $::dns_secundary::params::directory,
  Array[String] $listen_on_addr    = $::dns_secundary::params::listen_on_addr,
  Array[String] $listen_on_v6_addr = $::dns_secundary::params::listen_on_v6_addr,
  Array[String] $forwarders        = $::dns_secundary::params::forwarders,
  Boolean $forward                 = $::dns_secundary::params::forward,
  Array[String] $allow_query       = $::dns_secundary::params::allow_query,
  String $dump_file                = $::dns_secundary::params::dump_file,
  String $statistics_file          = $::dns_secundary::params::statistics_file,
  String $memstatistics_file       = $::dns_secundary::params::memstatistics_file,
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

}

