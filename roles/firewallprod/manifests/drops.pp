# Class: firewallprod::drops
# ===========================
#
# Full description of class firewallprod::drops here.
#
class firewallprod::drops {
    each($::firewallprod::host_todrop) |Integer $index, String $host|{
      firewall { $::firewallprod::host_todrop[$index] :
        chain  => 'INPUT',
        action => 'drop',
        source => $::firewallprod::host_todrop[$index],
      }
    }
}
