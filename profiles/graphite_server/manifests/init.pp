#
#  Class graphite_server
#================================
#

class graphite_server {
  class { 'graphite': 
  gr_max_updates_per_second => 100,
  gr_timezone               => 'America/Havana',
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
  gr_django_db_password     => 'MYsEcReT!.UPR',
  gr_django_db_host         => '120.0.0.1',
  gr_django_db_port         => '3306',
  gr_memcache_hosts         => ['127.0.0.1:11211']
  }
  
apache::vhost { 'graphite.upr.edu.cu':
  port    => '80',
  docroot => '/opt/graphite/webapp',
  wsgi_application_group      => '%{GLOBAL}',
  wsgi_daemon_process         => 'graphite',
  wsgi_daemon_process_options => {
    processes          => '5',
    threads            => '5',
    display-name       => '%{GROUP}',
    inactivity-timeout => '120',
  },
  wsgi_import_script          => '/opt/graphite/conf/graphite_wsgi.py',
  wsgi_import_script_options  => {
    process-group     => 'graphite',
    application-group => '%{GLOBAL}'
  },
  wsgi_process_group          => 'graphite',
  wsgi_script_aliases         => {
    '/' => '/opt/graphite/conf/graphite_wsgi.py'
  },
  headers => [
    'set Access-Control-Allow-Origin "*"',
    'set Access-Control-Allow-Methods "GET, OPTIONS, POST"',
    'set Access-Control-Allow-Headers "origin, authorization, accept"',
  ],
  directories => [{
    path => '/media/',
    order => 'deny,allow',
    allow => 'from all'}
  ]
}->
class { 'graphite':
  gr_web_server           => 'none',
  gr_disable_webapp_cache => true,
}
}

