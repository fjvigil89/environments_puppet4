# Class: dns_secundary
# ===========================
####   
class dns_secundary {
include bind
bind::server::conf { '/etc/named.conf':
  listen_on_addr => ['10.2.1.13','localhost'],
  directory      => '/var/cache/bind',
  recursion      => 'yes',
  forwarders     => [ '10.2.1.8' ],
  allow_query    => [ '10.2.0.0/15' ],

}
}

