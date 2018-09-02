# Class: firewallprod::accepts
# ===========================
#
# Full description of class firewallprod::accepts here.
#
class firewallprod::accepts {
  # FROM Reduniv ACCEPT
  $::firewallprod::hosts_toaccept.each |String $host|{
    firewall { "$host ACCEPT FROM RedUni":
      chain  => $::firewallprod::chain_from,
      action => 'accept',
      source => $host,
    }
  }
  #To RedUniv ACCEPT
  $::firewallprod::hosts_toaccept.each |String $host|{
    firewall { "$host ACCEPT to RedUniv":
      chain  => $::firewallprod::chain_to,
      action => 'accept',
      destination => $host,
    }
  }


}

