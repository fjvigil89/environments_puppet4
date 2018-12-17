node 'nginx-inverso.upr.edu.cu','proxy-inverso.upr.edu.cu','toran-proxy.upr.edu.cu' {  
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor proxy inverso',
    application    => 'Reverse Proxy UPR',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}

node 'reverse-proxy.upr.edu.cu'{
  class {'::reverseProxy_Server':
    server_name => [
      'correo.upr.edu.cu',
      'bower.upr.edu.cu',
      'cifam.upr.edu.cu',
      'coodes.upr.edu.cu',
      'cvforestal.upr.edu.cu',
      'intranet.upr.edu.cu',
      'proxy-login.upr.edu.cu',
      'catalogo.upr.edu.cu ',
      'composer.upr.edu.cu',
      'eventos.upr.edu.cu',
      'nexus.upr.edu.cu',
      'cfores.upr.edu.cu',
      'cooder.upr.edu.cu',
      'crai.upr.edu.cu',
      'harbor.upr.edu.cu',
      'proxy-go.upr.edu.cu'
    ],
    listen_port => [
      '443','80','80','80','80','80','443','80','80','80','80','80','80','80','80','443'
    ],
    ssl_port    => [
      '443','80','80','80','443','443','443','80','80','80','443','80','80','80','443','443'
    ],

  }
}
