#
#  Class graphite_server
#================================
#

class graphite_server {
class { 'graphite':
    gr_max_updates_per_second => 100,
    gr_timezone               => 'Europe/Berlin',
    secret_key                => 'CHANGE_IT!',
    gr_storage_schemas        => [
      {
        name       => 'carbon',
        pattern    => '^carbon\.',
        retentions => '1m:90d'
      },
      {
        name       => 'special_server',
        pattern    => '^longtermserver_',
        retentions => '10s:7d,1m:365d,10m:5y'
      },
      {
        name       => 'default',
        pattern    => '.*',
        retentions => '60:43200,900:350400'
      }
    ],
    gr_django_db_engine       => 'django.db.backends.mysql',
    gr_django_db_name         => 'graphite',
    gr_django_db_user         => 'graphite',
    gr_django_db_password     => 'MYsEcReT!',
    gr_django_db_host         => 'mysql.my.domain',
    gr_django_db_port         => '3306',
    gr_memcache_hosts         => ['127.0.0.1:11211']
  }
}

