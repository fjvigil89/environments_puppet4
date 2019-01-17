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
    frontend_name     => ['frontend_http', 'frontend_https'],
  }
    haproxy::frontend { 'frontend_http':
      mode    => $frontend_mode,
      options => {
        'default_backend' => 'backend_http',
        'timeout client'  => '30s',
        'option'          => [
          'tcplog',
        ],
      },
      bind    => {
        '0.0.0.0:80'  => [],
      },
    }
    haproxy::frontend { 'frontend_https':
      mode    => $frontend_mode,
      options => {
        'default_backend' => 'backend_https' ,
        'timeout client'  => '30s' ,
        'option'          => [
          'tcplog',
        ],
      },
      bind    => {
        '0.0.0.0:443'  => [],
      },
    }
    haproxy::backend { 'backend_http':
      mode    => 'http',
      options => {
        'option'  => [
          'tcplog',
        ],
        'balance' => 'roundrobin',
      },
    }
    haproxy::backend { 'backend_https':
      mode    => 'tcp',
      options => {
        'option'  => [
          'tcplog',
        ],
        'balance' => 'roundrobin',
      },
    }
    haproxy::balancermember { 'reverse-proxy0.upr.edu.cu':
      listening_service => 'backend_http',
      server_name       => 'reverse-proxy0.upr.edu.cu',
      ipaddresses       => '200.14.49.6',
      ports             => '80',
    }
    haproxy::balancermember { 'reverse-proxy1.upr.edu.cu':
      listening_service => 'backend_http',
      server_name       => 'reverse-proxy1.upr.edu.cu',
      ipaddresses       => '200.14.49.5',
      ports             => '80',
      } 
    haproxy::balancermember { 'reverse-proxy0.upr.edu.cu':
      listening_service => 'backend_https',
      server_name       => 'reverse-proxy0.upr.edu.cu',
      ipaddresses       => '200.14.49.6',
      ports             => '443',
      } 
      haproxy::balancermember { 'reverse-proxy1.upr.edu.cu':
        listening_service => 'backend_https',
        server_name       => 'reverse-proxy1.upr.edu.cu',
        ipaddresses       => '200.14.49.5',
        ports             => '443',
      }


    #frontend_options  => {
    #  'default_backend' => 'nginx_backend' ,
    #  'timeout client'  => '30s' ,
    #  'option'          => [
    #    'tcplog',
    #  ],
    #  },
    #backend_names     => ['backend_http','backend_https'],
    #backend_options   => {
    #  'option'  => [
    #    'tcplog',
    #  ],
    #  'balance' => 'roundrobin',
    #},
    #bind              => {
    #  '0.0.0.0:80'  => [],
    #  '0.0.0.0:443' => [],
    #},
    #}


}
