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
bind::server::conf {
  zones => {
    'example.com' => [
      'type master',
      'file "example.com"',
    ],
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

