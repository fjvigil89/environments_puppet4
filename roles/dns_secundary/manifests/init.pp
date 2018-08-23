# Class: dns_secundary
# ===========================
####   
class dns_secundary {
include bind
#bind::server::conf { '/etc/named.conf':
#listen_on_addr => ['10.2.1.13','localhost'],
#  directory      => '/var/cache/bind',
#  recursion      => 'yes',
#  forwarders     => [ '10.2.1.8' ],
#  allow_query    => [ '10.2.0.0/15' ],
#}
bind::server::conf { '/etc/named.conf':
  zones => {
    'tele4.upr.edu.cu' => [
      'type master',
      'file "db.upr.edu.cu"',
    ],
  },
  views => {
    'internal' => {
      'match-clients' => [ '10.2.0.0/15' ],
      'zones' => {
        'tele4.upr.edu.cu' => [
          'type master',
          'file "db.tele4.upr.edu.cu"',
        ],
      },
    },
    'default' => {
      'match-clients' => [ 'any' ],
    },
  },
}
bind::server::file { 'db.tele4.upr.edu.cu':
  source => 'puppet:///modules/dns_secundary/dns/db.tele4.upr.edu.cu',
}
}

