#
#  Class graphite_server
#================================
#

class graphite_server {
include '::mysql::server'
mysql::db { 'graphite':
  user     => 'graphite',
  password => 'graphite*upr.2k18',
  host     => '127.0.0.1',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
}


}

