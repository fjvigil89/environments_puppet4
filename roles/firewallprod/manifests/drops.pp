# Class: firewallprod::drops
# ===========================
#
# Full description of class firewallprod::drops here.
#
class firewallprod::drops {
    each($host_todrop) |String $host|{
      firewall{'Drop $host':
        action => 'drop',
        source => $host,
      }
    }
}
