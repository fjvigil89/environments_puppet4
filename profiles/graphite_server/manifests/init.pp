#
#  Class graphite_server
#================================
#

class graphite_server {
 class { '::mysql::server':
  root_password           => 'graphite.2k18',
  remove_default_accounts => true,
 } 
 mysql::db { 'graphite':
  user     => 'graphite',
  password => 'graphite*upr.2k18',
  host     => 'localhost',
  #  grant => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
  grant    =>  ['ALL'],
}


}

