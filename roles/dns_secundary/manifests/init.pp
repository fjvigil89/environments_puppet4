# Class: dns_secundary
# ===========================
#   
class dns_secundary {
include bind
bind::server::conf { '/etc/bind/named.conf.options':
  listen_on_addr => [ '10.2.1.205','localhost' ],
  forwarders     => [ '10.2.1.8' ], 
  allow_query    => [ '10.2.0.0/15' ],
}
}

