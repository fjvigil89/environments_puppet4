# Class: firewallprod::drops
# ===========================
#
# Full description of class firewallprod::drops here.
#
class firewallprod::drops {
    each($host_todrop) |Integer $index, String $host|{
      firewall { $host :
        chain  => 'INPUT',
        action => 'drop',
        source => $index,
      }
    }
}
