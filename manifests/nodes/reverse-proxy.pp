node 'toran-proxy.upr.edu.cu' {  
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor proxy inverso',
    application    => 'Reverse Proxy UPR',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
    dmz            => true,
  }
}

##Para hacer los proxy inversos
node /^reverse-proxy\d+$/{


  class { 'reverse_proxy_server':
    server_name    => [
      'correo.upr.edu.cu',#2 443
      
    ],
    #                  1 
    listen_port    => [443],
    #                  1 
    ssl_port       => [443],
    location_allow => [
      '*',#1
    ],

  }
}
