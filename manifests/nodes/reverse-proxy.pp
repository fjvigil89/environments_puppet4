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

##Para hacer los proxy inversos
node 'reverse-proxy.upr.edu.cu'{
  class { 'reverse_proxy_server':
    server_name    => [
      'correo.upr.edu.cu',
      'cvforestal.upr.edu.cu',
      'intranet.upr.edu.cu',
      'proxy-login.upr.edu.cu',
      'nexus.upr.edu.cu',
      'harbor.upr.edu.cu',
      'proxy-go.upr.edu.cu',
      'gitlab.upr.edu.cu',
      'puppetboard.upr.edu.cu',
      'icingaweb.upr.edu.cu',
      'composer.upr.edu.cu',
      'bower.upr.edu.cu',
      'cooder.upr.edu.cu',
      'npm.upr.edu.cu',
      'mendive.upr.edu.cu',
      'podium.upr.edu.cu',
    ],
    listen_port    => [80,80,80,443,80,80,443,80,80,80,80,80,80,80],
    ssl_port       => [443,443,443,443,443,443,443,80,80,80,80,80,80,80],
    location_allow => [
      '*',
      '*',
      'red_univ',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      'red_univ',
      'red_univ',
      'red_univ',
      'red_univ',
      '*',
      '*',
    ],

  }
}
