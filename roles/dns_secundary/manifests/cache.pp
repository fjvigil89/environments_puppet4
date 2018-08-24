#class: dns_secundary
# ===========================
#### 
class dns_secundary::cache(){
 bind::server::conf { $::dns_secundary::config_file :
  listen_on_addr    => $::dns_secundary::listen_on_addr,
  listen_on_v6_addr => $::dns_secundary::listen_on_v6_addr,
  forwarders        => $::dns_secundary::forwarders,
  allow_query       => $::dns_secundary::allow_query,

  zones             => $::dns_secundary::zone_name.each |String $value| {
    $value = [
        $::dns_secundary::zone_type,
        "file db.$value",
      ],

  },

  #zones             => {
  #  'myzone.lan' => [
  #    'type master',
  #    'file "myzone.lan"',
  #  ],
  #  '1.168.192.in-addr.arpa' => [
  #    'type master',
  #    'file "1.168.192.in-addr.arpa"',
  #  ],
  #},
}

  bind::server::file { $::dns_secundary::zone_name :
    source_base =>  'puppet:///modules/dns_secundary/dns/',
  }

}
