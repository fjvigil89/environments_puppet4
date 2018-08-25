#class: dns_secundary
# ===========================
#### 
class dns_secundary::cache(){

  

 bind::server::conf { $::dns_secundary::config_file :
  listen_on_addr           => $::dns_secundary::listen_on_addr,
  listen_on_v6_addr        => $::dns_secundary::listen_on_v6_addr,
  forwarders               => $::dns_secundary::forwarders,
  allow_query              => $::dns_secundary::allow_query,
  directory                => $::dns_secundary::directory,
  dump_file                => $::dns_secundary::dump_file,
  statistics_file          => $::dns_secundary::statistics_file,
  memstatistics_file       => $::dns_secundary::memstatistics_file,
  
  #zones                   => {
  #  'upr.edu.cu'          => [
  #    'type master',
  #    'file "db.upr.edu.cu"',
  #  ],
  #  '1.2.10.in-addr.arpa' => [
  #    'type master',
  #    'file "db.1.2.10.in-addr.arpa"',
  #  ],
  #},
}

#bind::server::file { $::dns_secundary::file_zone_name :
#    source_base =>  'puppet:///modules/dns_secundary/dns/',
#  }

}
