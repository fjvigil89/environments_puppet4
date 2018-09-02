# Class: firewallprod
# ===========================
#
# Full description of class firewallprod here.
#
class firewallprod (
  Array[String] $hosts_todrop = $::firewallprod::params::hosts_todrop,
) inherits ::firewallprod::params {
  class { '::server_firewall':; }
  class { '::firewallprod::drops':;}

}
}
