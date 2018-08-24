# Class: dns_secundary::params
# ===========================
#
# Full description of class dns_secundary::params here.
#
class dns_secundary::params{
    $config_file        = '/etc/named.conf'
    $listen_on_addr     = [ 'any' ]
    $listen_on_v6_addr  = [ 'any' ]
    $forwarders      = ['10.2.1.8']
    $allow_query     = [ 'any' ]
    $zone_name       = ['upr.edu.cu','ceces.upr.edu.cu']
    $file_zone_name  = ['db.upr.edu.cu','db.ceces.upr.edu.cu']
    $zone_reverse    = ['1.2.10.in-addr.arpa','22.2.10.in-addr.arpa']
    $zone_type       = 'type master'
    #$recursion       = 'yes'
    #$notify          = 'yes'
    #$mymasters       = [ '192.168.0.1', '192.168.0.2']
    #$mymatch_clients = [ '10.2.0.0/15', '200.14.49.0/24']
}
