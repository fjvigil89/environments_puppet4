# Class: firewallprod::drops
# ===========================
#
# Full description of class firewallprod::drops here.
#
class firewallprod::drops {
  $::firewallprod::hosts_todrop.each |String $host|{
    firewall { $host:
      chain  => 'INPUT',
      action => 'drop',
      source => $host,
    }
  }
}
