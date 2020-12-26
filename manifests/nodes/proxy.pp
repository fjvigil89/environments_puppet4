node /^proxy\d+$/ {  
   package { 'lsb-release':
          ensure => installed,
          }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor Proxy',
    application    => 'Servidor Proxy Squid',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => false,
    puppet_enabled  => true,
    dns_preinstall  => true,
  }
  

}

node 'ha-proxy.upr.edu.cu' {

  package { 'lsb-release':
          ensure => installed,
          }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor Ha-Proxy',
    application    => 'Servidor Ha-Proxy Squid',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => false,
    puppet_enabled  => true,
    dns_preinstall  => true,
  }


  class {'::haproxy_serv':
    enable_ssl        => false,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'proxy',
    mode              => 'http',
    balancer_member   => ['proxy1','proxy2'],
    server_names      => ['proxy1.upr.edu.cu','proxy2.upr.edu.cu'],
    ipaddresses       => ['10.2.1.75','10.2.1.77'],
    ports             => ['8080'],
  }
  haproxy::listen { 'proxy_http':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '8080',
    options          => {
      'balance' => 'roundrobin',
    },
  }
  haproxy::balancermember { 'proxy1':  
    listening_service => 'proxy_http',
    server_names      => 'proxy1.upr.edu.cu',
    ipaddresses       => '10.2.1.75',
    ports             => '8080',
  }

  haproxy::balancermember { 'proxy2':
    listening_service => 'proxy_http',
    server_names      => 'proxy2.upr.edu.cu',
    ipaddresses       => '10.2.1.77',
    ports             => '8080',
  }

}

