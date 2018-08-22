# Class: dns_secundary
# ===========================
#   
class dns_secundary {
include bind
bind::server::conf { '/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  forwarders        => [ '10.2.1.8' ],
  allow_query       => [ 'any' ],
  zones             => {
    'upr.edu.cu' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.upr.edu.cu"',
    ],
    '1.2.10.in-addr.arpa' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.1.2.10.in-addr.arpa"',
    ],
    '22.2.10.in-addr.arpa' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.22.2.10.in-addr.arpa"',
    ],
    '24.2.10.in-addr.arpa' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.24.2.10.in-addr.arpa"',
    ],
  },
}
bind::server::file { ['db.upr.edu.cu','db.1.2.10.in-addr.arpa','db.22.2.10.in-addr.arpa','db.24.2.10.in-addr.arpa']:
  source => 'puppet:///modules/dns_secundary/dns/',
}
}
