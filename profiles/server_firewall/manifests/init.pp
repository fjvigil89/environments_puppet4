# Class: server_firewall
# ===========================
#
# Full description of class server_firewall here.
#
class server_firewall {
  class { 'firewall':; }
  class { '::server_firewall::pre_rules':; }
  class { '::server_firewall::post_rules':; }
}
