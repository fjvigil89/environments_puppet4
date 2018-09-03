#class: dns_primary::primary
# ===========================
#### 
class dns_primary::primary(){
  bind::server::conf { $::dns_primary::config_file :
    listen_on_addr     => $::dns_primary::listen_on_addr,
    listen_on_v6_addr  => $::dns_primary::listen_on_v6_addr,
    forwarders         => $::dns_primary::forwarders,
    forward            => $::dns_primary::forward,
    allow_query        => $::dns_primary::allow_query,
    directory          => $::dns_primary::directory,
    dump_file          => $::dns_primary::dump_file,
    statistics_file    => $::dns_primary::statistics_file,
    memstatistics_file => $::dns_primary::memstatistics_file,
    #views              => $::dns_primary::views,
    zones                   => {
     'upr.edu.cu'          => [
       'type master',
       'file "db.upr.edu.cu"',
     ],
     '1.2.10.in-addr.arpa' => [
       'type master',
       'file "db.1.2.10.in-addr.arpa"',
     ],
   },
    views => {
     'internal' => {
       'match-clients' => [ '127.0.0.1','200.14.49.0/27','200.55.143.8/29','152.207.173.40/29','10.2.1.8/32' ],
       'allow-query'   => [ '127.0.0.1','200.14.49.0/27','200.55.143.8/29','152.207.173.40/29','10.2.1.8/32' ],
       'recursion'     => 'yes',
       'zones' => {
         'myzone.lan' => [
           'type master',
           'file "myzone.lan"',
         ],
       },
    },
    #'default' => {
    #  'match-clients' => [ 'any' ],
    #},
  },
}

 bind::server::file { $::dns_primary::file_zone_name :
     source_base =>  'puppet:///modules/dns_primary/dns/',
  }

}

