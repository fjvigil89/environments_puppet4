# Class: dns_secundary
# ===========================
####   
class dns_secundary {
include bind
bind::server::conf { '/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  listen_on_v6_addr => [ 'any' ],
  forwarders        => [ '10.2.1.13' ],
  allow_query       => [ 'localnets' ],
  zones             => {
    'upr.edu.cu' => [
      'type master',
      'file "db.upr.edu.cu"',
    ],
    '1.2.10.in-addr.arpa' => [
      'type master',
      'file "db.1.2.10.in-addr.arpa"',
    ],
  },
}
bind::server::file { 'db.upr.edu.cu':
  source => 'puppet:///modules/dns_secundary/dns/db.upr.edu.cu',
}
bind::server::file { 'db.1.2.10.in-addr.arpa':
  source => 'puppet:///modules/dns_secundary/dns/db.1.2.10.in-addr.arpa',
}
}

