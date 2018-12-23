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
    balancer_member   => ['reverse-proxy0'],
    server_names      => ['reverse-proxy0.upr.edu.cu'],
    ipaddresses       => ['200.14.49.6'],
    ports             => ['80','443'],
    #options           => 'check',
  }
}
