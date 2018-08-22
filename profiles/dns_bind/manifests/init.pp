# Class: dns_bind
# ===========================
# 
# Full description of class dns_bind here.
#
class dns_bind (
  Array[String] $zone_name       = $::dns_bind::params::zone_name,
  Array[String] $zone_reverse    = $::dns_bind::params::zone_reverse,
  String $zone_type              = $::dns_bind::params::zone_type,
  # String $recursion              = $::dns_bind::params::recursion,
  #String $notify                 = $::dns_bind::params::notify,
  Array[String] $mymasters       = $::dns_bind::params::mymasters,
  Array[String] $mymatch_clients = $::dns_bind::params::mymatch_clients,
) inherits ::dns_bind::params {
include bind
bind::server::conf { '/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  listen_on_v6_addr => [ 'any' ],
  forwarders        => [ '8.8.8.8', '8.8.4.4' ],
  allow_query       => [ 'localnets' ],
  zones             => {
    'myzone.lan' => [
      'type master',
      'file "myzone.lan"',
    ],
    '1.168.192.in-addr.arpa' => [
      'type master',
      'file "1.168.192.in-addr.arpa"',
    ],
  },
}
}
