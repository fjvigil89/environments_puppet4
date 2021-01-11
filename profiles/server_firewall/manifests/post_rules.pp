# Class: server_firewall::post_rules
# ===========================
#
# Full description of class server_firewall::post_rules here.
#
class server_firewall::post_rules {
class my_fw::post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
}
