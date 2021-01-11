# Class: ucarp_vip::params
# ===========================
#
# Full description of class arian here.
#
#
class ucarp_vip::params {
  $bind_interface   = 'eth0'
  $password         = 'secret'
  $hosts              = {}
  $vip_address      = '10.2.0.0'
  $source_address   = $::ipaddress
  $master_hostname  = $::hostname
}
