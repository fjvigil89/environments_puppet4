# Class: firewallprod::drops
# ===========================
#
# Full description of class firewallprod::drops here.
#
class firewallprod::drops {
if($::firewallprod::drop_both){
  $::firewallprod::hosts_todrop.each |String $host|{
    firewall { "$host Source DROP":
      chain  => 'INPUT',
      action => 'drop',
      source => $host,
    }
  }
$::firewallprod::hosts_todrop.each |String $host|{
  firewall { "$host Destination DROP":
    chain       => 'INPUT',
    action      => 'drop',
    destination => $host,
  }
}
}
}

