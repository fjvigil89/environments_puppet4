# Class: firewallprod::params
# ===========================
#
# Full description of class firewallprod::params here.
#
class firewallprod::params {
  # When you want drop source and destination
  $drop_both      = true
  
  #list of hosts to drop or accept 
  $hosts_todrop   = []
  $hosts_toaccept = []

  # INPUT, OUTPUT, PREROUTING, POSTROUTING, FORWARD
  $chain        = ''
  # ACCEPT, REJECT, DROP, MARK, ....
  $action       = ''

}
