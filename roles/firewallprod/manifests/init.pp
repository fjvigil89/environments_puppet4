# Class: firewallprod
# ===========================
#
# Full description of class firewallprod here.
#
class firewallprod (
  Boolean $delete_iptables      = $::firewallprod::params::delete_iptables,
  Boolean $drop_both            = $::firewallprod::params::drop_both, 
  Array[String] $hosts_todrop   = $::firewallprod::params::hosts_todrop,
  Array[String] $hosts_toaccept = $::firewallprod::params::hosts_toaccept, 
  Array[String] $open_ports     = $::firewallprod::params::open_ports,
  String $chain_from            = $::firewallprod::params::chain_from,
  String $chain_to              = $::firewallprod::params::chain_to,

  Enum['INPUT', 'OUTPUT', 'PREROUTING', 'POSTROUTING', 'FORWARD'] $chain = 'INPUT',
  Enum['ACCEPT', 'REJECT','DROP', 'MARK'] $action = 'ACCEPT',

) inherits ::firewallprod::params {
  if($delete_iptables){
    resources { 'firewall':
      purge => true,
    }
  }
  firewallchain { "$chain_from:filter:IPv4" :
    ensure => present,
  }
  firewallchain { "$chain_to:filter:IPv4" :
    ensure => present,
  }

  class { '::server_firewall':; }
  class { '::firewallprod::drops':;}
  class { '::firewallprod::accepts':;}
  class { '::firewallprod::ports':;}
}
