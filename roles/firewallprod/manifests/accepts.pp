# Class: firewallprod::accepts
# ===========================
#
# Full description of class firewallprod::accepts here.
#
class firewallprod::accepts {
  # FROM Reduniv ACCEPT
  $::firewallprod::hosts_toaccept.each |String $host|{
    firewall { "$host ACCEPT FROM RedUni":
      chain     => $::firewallprod::chain_from,
      action    => 'accept',
      src_range => $host,
    }
  }
  #To RedUniv ACCEPT
  $::firewallprod::hosts_toaccept.each |String $host|{
    firewall { "$host ACCEPT to RedUniv":
      chain     => $::firewallprod::chain_from,
      action    => 'accept',
      dst_range => $host,
    }
  }


}

