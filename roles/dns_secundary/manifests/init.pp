# Class: dns_secundary
# ===========================
#   
class dns_secundary {
include bind
bind::server::conf {
  zones             => {
    'upr.edu.cu' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.upr.edu.cu"',
    ],
    'ceces.upr.edu.cu' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.ceces.upr.edu.cu"',
    ],
    'progintec.upr.edu.cu' => [
      'type slave',
      'masters { 10.2.24.158; }',
      'file "db.progintec.upr.edu.cu"',
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
views => {
    'trusted' => {
      'match-clients' => [ '10.2.0.0/15' ],
      'zones' => {
     'upr.edu.cu' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.upr.edu.cu"',
    ],
    'ceces.upr.edu.cu' => [
      'type slave',
      'masters { 10.2.1.8; }',
      'file "db.ceces.upr.edu.cu"',
    ],
    'progintec.upr.edu.cu' => [
      'type slave',
      'masters { 10.2.24.158; }',
      'file "db.progintec.upr.edu.cu"',
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

      },
'default' => {
      'match-clients' => [ 'any' ],
    },
    },

bind::server::file { 'db.upr.edu.cu':
  source => 'puppet:///modules/dns_secundary/dns/db.upr.edu.cu',
  mode   => '0770',
}

bind::server::file { 'db.1.2.10.in-addr.arpa':
  source => 'puppet:///modules/dns_secundary/dns/db.1.2.10.in-addr.arpa',
  mode   => '0770',
}

bind::server::file { 'db.22.2.10.in-addr.arpa':
  source => 'puppet:///modules/dns_secundary/dns/db.22.2.10.in-addr.arpa',
  mode   => '0770',
}

bind::server::file { 'db.24.2.10.in-addr.arpa':
  source => 'puppet:///modules/dns_secundary/dns/db.24.2.10.in-addr.arpa',
  mode   => '0770',
}

bind::server::file { 'db.ceces.upr.edu.cu':
  source => 'puppet:///modules/dns_secundary/dns/db.ceces.upr.edu.cu',
  mode   => '0770',
}

bind::server::file { 'db.progintec.upr.edu.cu':
  source => 'puppet:///modules/dns_secundary/dns/db.progintec.upr.edu.cu',
  mode   => '0770',
}
}
