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
  zones => {
    each($zone_name) |$zone| {
    $zone = [
      'type master',
      'file "example.com"',
    ],
    }
  },
  views => {
    'trusted' => {
      'match-clients' => [ '192.168.23.0/24' ],
      'zones' => {
        'myzone.lan' => [
          'type master',
          'file "myzone.lan"',
        ],
      },
    },
    'default' => {
      'match-clients' => [ 'any' ],
    },
  },
}
}
