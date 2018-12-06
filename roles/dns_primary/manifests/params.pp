# Class: dns_primary::params
# ===========================
#
# Full description of class dns_primary::params here.
#
class dns_primary::params{
    $config_file        = '/etc/named.conf'
    $listen_on_addr     = [ 'any' ]
    $listen_on_v6_addr  = [ 'any' ]
    $forwarders      	  = ['10.2.1.8']
    $forward	     	    = false			
    $allow_query     	  = '{ any; }' 
    $directory          = '/etc/bind'
    $dump_file          = 'cache_dump.db'
    $statistics_file    = 'named_stats.txt'
    $memstatistics_file =  'named_mem_stats.txt'
    $zone_name       	  = ['upr.edu.cu','ceces.upr.edu.cu']
    $file_zone_name  	  = ['db.upr.edu.cu','db.ceces.upr.edu.cu','db.tele4.upr.edu.cu']
    $zone_reverse    	  = ['1.2.10.in-addr.arpa','22.2.10.in-addr.arpa']
    $zone_type       	  = 'type master'
    $recursion       	  = 'yes'
    $notify          	  = 'yes'
    $mymasters       	  = "{ 10.2.1.8; 192.168.0.2; }"
    $mymatch_clients 	  = [ '10.2.0.0/15', '200.14.49.0/24']
    $views		          = {}
    $zones              = {}
}
