# Class: dns_secundary::params
# ===========================
#
# Full description of class dns_secundary::params here.
#
class dns_secundary::params{
    $config_file        = '/etc/named.conf'
    $listen_on_addr     = [ 'any' ]
    $listen_on_v6_addr  = [ 'any' ]
    $forwarders         = ['10.2.1.8']
    $allow_query        = [ 'any' ]
    $directory          = '/etc/bind'
    $dump_file          = 'cache_dump.db'
    $statistics_file    = 'named_stats.txt'
    $memstatistics_file = 'named_mem_stats.txt'
}
