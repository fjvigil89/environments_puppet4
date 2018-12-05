##class: dns_primary::primary
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
   # zones                   => {
     #'upr.edu.cu'          => [
      # 'type master',
      # 'file "db.upr.edu.cu"',
      # 'allow-update { 200.55.143.10; }',
      # 'allow-transfer { 200.55.143.10; }',
      # 'also-notify { 200.55.143.10; }',
      # 'notify yes',

     #],
     #'1.2.10.in-addr.arpa' => [
     #  'type master',
     #  'file "db.1.2.10.in-addr.arpa"',
     #],
   #},
   # views => {
   #  'internal' => {
   #    'match-clients' => [ '10.2.0.0/15' ],
   #    'allow-query'   => [ '10.2.0.0/15' ],       
   #    'zones' => {
   #      'tele4.upr.edu.cu' => [
   #        'type master',
   #        'file "/etc/bind/db.tele4.upr.edu.cu"',
   #  'allow-update { 10.2.1.8; }',	
   #        'allow-transfer { 10.2.1.8; }',
   #        'also-notify { 10.2.1.8; }',
   #        'notify yes',
   #      ],
   #    },
   # },
    #'default' => {
    #  'match-clients' => [ 'any' ],
    #},
  },
}

 #bind::server::file { $::dns_primary::file_zone_name :
     #zonedir     =>  '/etc/bind',
     #source_base =>  'puppet:///modules/dns_primary/dns/',
  #}
  vcsrepo { '/etc/bind/zone':
    ensure   => present,
    provider => 'git',
    source   => 'git@gitlab.upr.edu.cu:dcenter/bd_dns.git',
    revision => 'master',
  }


}
