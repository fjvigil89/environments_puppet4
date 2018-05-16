#
#  Class graphite_server
#================================
#

class graphite_server {
class { 'graphite':
    gr_django_db_engine       => 'django.db.backends.mysql',
    gr_django_db_name         => 'graphite',
    gr_django_db_user         => 'graphite',
    gr_django_db_password     => 'MYsEcReT!',
    gr_django_db_host         => 'mysql.my.domain',
    gr_django_db_port         => '3306',
    gr_memcache_hosts         => ['127.0.0.1:11211']
  }
}

