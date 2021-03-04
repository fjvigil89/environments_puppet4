#
#  Class graphite_server
#================================
#

class graphite_server {
class { 'postgresql::server':}
postgresql::server::db { 'graphite':
  user     => 'graphite',
  password => postgresql_password('graphite', 'graphite.2k18'),
}

}

