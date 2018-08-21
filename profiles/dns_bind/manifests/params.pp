# Class: dns_bind::params
# ===========================
#
# Full description of class dns_bind::params here.
#
class dns_bind::params {
    $zone_name       = ['upr.edu.cu','ceces.upr.edu.cu']
    $zone_reverse    = ['1.2.10.in-addr.arpa','22.2.10.in-addr.arpa']
    $zone_type       = 'type master'
    $recursion       = 'yes'
    $notify          = 'yes'
    $mymasters       = [ '192.168.0.1', '192.168.0.2']
    $mymatch_clients = [ '10.2.0.0/15', '200.14.49.0/24']
}
