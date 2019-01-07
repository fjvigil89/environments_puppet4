node 'ha-reverse-proxy.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor gestion',
    application     => 'Proxmox Gestion',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
  class {'::haproxy_serv':
    ipaddress         => $ipaddress,
    listening_service => 'nginx',
    mode              => 'http',
    balancer_member   => ['reverse-proxy0','reverse-proxy1'],
    server_names      => ['reverse-proxy0.upr.edu.cu','reverse-proxy1.upr.edu.cu'],
    ipaddresses       => ['200.14.49.6','200.14.49.5'],
    ports             => ['80','80'],
    #options           => 'check',
  }
}
