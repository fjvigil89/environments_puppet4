# Class: firewallprod
# ===========================
#
# Full description of class firewallprod here.
#
class firewallprod {
  class { '::server_firewall': }
  firewall { '100 snat for network foo2':
  chain    => 'POSTROUTING',
  jump     => 'MASQUERADE',
  proto    => 'all',
  outiface => 'eth0',
  source   => '10.1.2.0/24',
  table    => 'nat',
}
}
