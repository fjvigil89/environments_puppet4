# Class: firewallprod::accepts
# ===========================
#
# Full description of class firewallprod::accepts here.
#
class firewallprod::accepts {
  #Line Value
  $line = 0;
  # FROM Reduniv ACCEPT
  $::firewallprod::hosts_toaccept.each |String $host|{
    firewall { "$line $host ACCEPT FROM RedUniv":
      chain  => $::firewallprod::chain_from,
      action => 'accept',
      source => $host,
    }
    $line = $line + 1
  }
  #To RedUniv ACCEPT
  $::firewallprod::hosts_toaccept.each |String $host|{
    firewall { "$line $host ACCEPT to RedUniv":
      chain       => $::firewallprod::chain_to,
      action      => 'accept',
      destination => $host,
    }
    $line = $line + 1
  }


}

