# Class: ucarp_vip
# ===========================
#
# Full description of class ucarp_vip here.
#
#
class ucarp_vip (
 Optional[String] $bind_interface   = $::ucarp_vip::params::bind_interface, 
 Optional[String] $password         = $::ucarp_vip::params::password,
 Optional[Hash] $hosts              = $::ucarp_vip::params::hosts,
 Optional[String] $vip_address      = $::ucarp_vip::params::vip_address,
 Optional[String] $source_address   = $::ucarp_vip::params::source_address,
 Optional[String] $master_hostname  = $::ucarp_vip::params::master_hostname,

) inherits ::ucarp_vip::params {
  class { '::ucarp':
    bind_interface => $bind_interface,
    password       => $password,
  }
  ucarp::host { '001':
    bind_interface  => $bind_interface,
    vip_address     => $vip_address,
    source_address  => $source_address,
    master_hostname => $master_hostname,
  }
}
