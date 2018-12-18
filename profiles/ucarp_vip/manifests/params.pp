# Class: ucarp_vip::params
# ===========================
#
# Full description of class arian here.
#
#
class ucarp_vip::params {
  String $bind_interface   = 'eth0'
  String $password         = 'secret'
  Hash $hosts              = {}
  String $vip_address      = '10.2.0.0'
  String $source_address   = $::ipaddress
  String $master_hostname  = $::hostname
}
