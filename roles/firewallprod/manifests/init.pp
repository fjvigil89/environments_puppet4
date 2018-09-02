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

  Enum['INPUT', 'OUTPUT', 'PREROUTING', 'POSTROUTING', 'FORWARD'] $chain = 'INPUT',
  Enum['ACCEPT', 'REJECT','DROP', 'MARK'] $action = 'ACCEPT',

) inherits ::firewallprod::params {
  class { '::server_firewall':; }
  class { '::firewallprod::drops':;}
  if($delete_iptables){
    resources { 'firewall':
      purge => true,
    }
  }
}
