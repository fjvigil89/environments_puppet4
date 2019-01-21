node 'ha-media.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor HAproxy Media',
    application     => 'HA proxy Media',
    repos_enabled   => true,
    mta_enabled     => false,
  }

  class {'::haproxy_serv':
    enable_ssl        => false,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'media',
    mode              => 'http',
    balancer_member   => ['media0','media1','media2'],
    server_names      => ['media0.upr.edu.cu','media1.upr.edu.cu','media2.upr.edu.cu'],
    ipaddresses       => ['10.2.24.3','10.2.24.4','10.2.24.5'],
    ports             => ['80'],
    frontend_name     => ['media_server'],
    frontend_options  => {
      'default_backend' => 'media_backend' ,
      'timeout client'  => '30s' ,
      'option'          => [
        'tcplog',
      ],
      },
    backend_names     => ['media_backend'],
    backend_options   => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
    bind              => {
      '0.0.0.0:80'  => [],
    },
  }
  haproxy::frontend { 'media_http':
    mode    => $frontend_mode,
    options => {
      'default_backend' => 'media_bhttp' ,
      'timeout client'  => '30s' ,
      'option'          => [
        'tcplog',
      ],
    },
    bind    => {
      '0.0.0.0:80'  => [],
    },
  }
  haproxy::backend { 'media_bhttp':
    mode    => 'http',
    options => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
  }
  haproxy::balancermember { 'media0.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media0.upr.edu.cu',
    ipaddresses       => '10.2.24.3',
    ports             => '80',
  }
  haproxy::balancermember { 'media1.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media1.upr.edu.cu',
    ipaddresses       => '10.2.24.3',
    ports             => '80',
  }
 haproxy::balancermember { 'media2.upr.edu.cu':
   listening_service => 'media_bhttp',
   server_names      => 'media2.upr.edu.cu',
   ipaddresses       => '10.2.24.3',
   ports             => '80',
 }

}
node /^media\d+$/ {
class { '::basesys':
  uprinfo_usage   => 'Servidor HA Media',
  application     => 'HA Media',
  repos_enabled   => true,
  mta_enabled     => false,
}
include apache
apache::vhost { 'media.upr.edu.cu':
  port    => '80',
  docroot => '/srv/httpdirindex',
}
}

