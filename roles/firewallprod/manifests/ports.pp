# Class: firewallprod::ports
# ===========================
#
# Full description of class firewallprod::accepts here.
#
class firewallprod::ports {
  $::firewallprod::open_ports.each |Integer $port|{
    firewall { "$port Open":
      dport  => $port,
      action => 'accept',
    }
  }


}

