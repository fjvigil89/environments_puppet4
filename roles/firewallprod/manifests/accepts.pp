# Class: firewallprod::accepts
# ===========================
#
# Full description of class firewallprod::accepts here.
#
class firewallprod::accepts {
  # FROM Reduniv ACCEPT
  $::firewallprod::hosts_toaccept.each |Integer $index, String $host|{
    firewall { "$index $host ACCEPT FROM RedUniv":
      chain  => $::firewallprod::chain_from,
      action => 'accept',
      source => $host,
    }
  }
  #To RedUniv ACCEPT
  $::firewallprod::hosts_toaccept.each |Integer $index, String $host|{
    firewall { "$index $host ACCEPT to RedUniv":
      chain       => $::firewallprod::chain_to,
      action      => 'accept',
      destination => $host,
    }
  }


}

