# Class: dns_bind::params
# ===========================
#
# Full description of class dns_bind::params here.
#
class dns_bind::params {
    $zone_name        = []
    $zone_reverse     = []
    $zone_type        = 'type master'
    $recursion        = 'yes'
    $listen_on_addr   = []
    $mymasters        = []
    $mymatch_clients  = [ '10.2.0.0/15' ]
    $dns_master       = 'true'
}
