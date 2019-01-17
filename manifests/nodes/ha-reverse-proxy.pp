node 'ha-reverse-proxy.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor gestion',
    application     => 'Proxmox Gestion',
    repos_enabled   => true,
    mta_enabled     => false,
  }

  class {'::haproxy_serv':
    enable_ssl        => true,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'nginx_backend',
    mode              => 'http',
    balancer_member   => ['reverse-proxy0','reverse-proxy1'],
    server_names      => ['reverse-proxy0.upr.edu.cu','reverse-proxy1.upr.edu.cu'],
    ipaddresses       => ['200.14.49.6','200.14.49.5'],
    ports             => ['80','443'],
    frontend_name     => ['nginx_server'],
    frontend_options  => {
      'default_backend' => 'nginx_backend' ,
      'timeout client'  => '30s' ,
      'option'          => [
        'tcplog',
      ],
      },
    backend_names     => ['nginx_backend'],
    backend_options   => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
    bind              => {
      '0.0.0.0:80'  => [],
      '0.0.0.0:443' => [],
    },
  }

}
