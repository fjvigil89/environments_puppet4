#class: basesys::firewall
# ===========================
#
# firewall basesys configure

class basesys::firewall {
if($enable_firewall){
  each($::basesys::params::upr_networks) |Integer $index, String $value|{
    firewall { "Abriendo puertos para redes: $::basesys::params::upr_networks[$index]":
      dport  => $::basesys::params::open_ports,
      #proto => $::basesys::params::proto_ports[$index],
      proto  => 'all',
      action => 'accept',
      source => $::basesys::params::upr_networks,
      notify{ "Abriendo los puertos:$::basesys::params::open_ports con origen:$::basesys::params::upr_networks[$index] al Firewall":},
    }
  }
}
}
