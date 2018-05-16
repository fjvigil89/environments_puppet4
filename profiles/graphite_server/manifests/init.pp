#
#  Class graphite_server
#================================
#

class graphite_server {
include '::apache'
class { 'graphite':
}->
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
  wsgi_import_script          => '/opt/graphite/conf/graphite.wsgi',
  wsgi_import_script_options  => {
    process-group     => 'graphite',
    application-group => '%{GLOBAL}'
  },
  wsgi_process_group          => 'graphite',
  wsgi_script_aliases         => {
    '/' => '/opt/graphite/conf/graphite.wsgi'
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
}


class {'grafana':
  graphite_host      => 'graphite.upr.edu.cu',
  elasticsearch_host => 'elasticsearach.my.domain',
  elasticsearch_port => 9200,
}->
apache::vhost { 'grafana.upr.edu.cu':
  servername      => 'grafana.upr.edu.cu',
  port            => 80,
  docroot         => '/opt/grafana',
  error_log_file  => 'grafana_error.log',
  access_log_file => 'grafana_access.log',
  directories     => [
    {
      path            => '/opt/grafana',
      options         => [ 'None' ],
      allow           => 'from All',
      allow_override  => [ 'None' ],
      order           => 'Allow,Deny',
    }
  ]
}

}

