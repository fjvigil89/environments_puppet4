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
    zones              => $::dns_primary::zones,
    views              => $::dns_primary::views 
  },


 #bind::server::file { $::dns_primary::file_zone_name :
     #zonedir     =>  '/etc/bind',
     #source_base =>  'puppet:///modules/dns_primary/dns/',
  #}
  #vcsrepo { '/etc/bind/zone':
  #  ensure   => present,
  #  provider => 'git',
  #  source   => '',
  #  revision => 'master',
  #}


}
