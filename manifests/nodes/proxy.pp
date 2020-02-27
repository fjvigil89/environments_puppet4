node 'proxy-tor.upr.edu.cu','proxy-pap.upr.edu.cu' {  
   package { 'lsb-release':
          ensure => installed,
          }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor Proxy',
    application    => 'Servidor Proxy Squid',
    mta_enabled    => false,
	dmz            => true,
  }
  class {'::filebeatserver':
    paths    => '/var/log/squid/*',
    log_type => "proxy",
   }

  class {'::metricbeatserver':
    modules  => ['system']
  }
  

}

node 'proxy-go.upr.edu.cu'{
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'Servidor Proxy',
    application   => 'Servidor Proxy GO',
    mta_enabled   => false,
    dmz           => true,
     
  }
  class {'::filebeatserver':
    paths    => '/etc/pmproxy/logs/*',
    log_type => "proxy",
   }
  class {'::metricbeatserver':
    modules  => ['system','golang']
  }
  


}
