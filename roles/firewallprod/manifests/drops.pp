# Class: firewallprod::drops
# ===========================
#
# Full description of class firewallprod::drops here.
#
class firewallprod::drops {
  $::firewallprod::hosts_todrop.each |Integer $index|{
    firewall { $::firewallprod::hosts_todrop[$index]:
      chain  => 'INPUT',
      action => 'drop',
      source => $::firewallprod::hosts_todrop[$index],
    }
  }
}
