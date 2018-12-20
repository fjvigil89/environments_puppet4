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

  $hosts = "
  10.2.1.30 puppet-master puppetboard
  10.2.24.85 repos.upr.edu.cu
  "
  file_line { 'add_ip_reverse':
    ensure => present,
    path   => '/etc/hosts',
    line   => $hosts,
    match  => '^# --- BEGIN PVE ---',
  }

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
      'cfores.upr.edu.cu',
      'cifam.upr.edu.cu', 
      'coodes.upr.edu.cu',
      'rc.upr.edu.cu',
      'crai.upr.edu.cu',
      'blogcrai.upr.edu.cu',
      'revistaecovida.upr.edu.cu',
      'tocororo.upr.edu.cu',
      'eventos.upr.edu.cu',
    ],
    listen_port    => [80,80,80,443,80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
    ssl_port       => [443,443,443,443,443,443,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
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
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
    ],

  }
}
