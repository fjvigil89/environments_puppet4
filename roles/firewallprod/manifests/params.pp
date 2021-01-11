# Class: firewallprod::params
# ===========================
#
# Full description of class firewallprod::params here.
#
class firewallprod::params {
  #To delete iptables
  $delete_iptables = true
  # When you want drop source and destination
  $drop_both      = true
  
  #list of hosts to drop or accept 
  $hosts_todrop   = []
  $hosts_toaccept = []
  
  #list of ports to open
  $open_ports    =  []
  # INPUT, OUTPUT, PREROUTING, POSTROUTING, FORWARD
  $chain        = ''
  # ACCEPT, REJECT, DROP, MARK, ....
  $action       = ''
  # Most be {chain}:{table}:{protocol}
  # Example: INPUT:filter:IPv4
  $chain_from   = ''
  $chain_to     = ''
}
