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
  }
}

##Para hacer los proxy inversos
node /^reverse-proxy\d+$/{


  class { 'reverse_proxy_server':
    server_name    => [
      'www.upr.edu.cu',
      'correo.upr.edu.cu',
      'cvforestal.upr.edu.cu',
      'intranet.upr.edu.cu',
      'proxy-login.upr.edu.cu',
      'nexus.upr.edu.cu',
      'harbor.upr.edu.cu',
      'proxy-go.upr.edu.cu',
      'gitlab.upr.edu.cu',
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
      'moodle.upr.edu.cu',
      'telefonos.upr.edu.cu',
      'mrtg.upr.edu.cu',
      'ftp.upr.edu.cu',
      'media.upr.edu.cu',
      'catalogo.upr.edu.cu',
      'archivos.upr.edu.cu',
      'repositorio.biblioteca.upr.edu.cu'
    ],
    listen_port    => [80,80,80,80,443,80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
    ssl_port       => [80,443,443,443,443,443,443,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
    location_allow => [
      '*',
      '*',
      '*',
      'red_univ',
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
      '*',
      '*',
      'red_univ',
      'cuba',
      'red_univ',
      'red_univ',
      'red_univ',
      'red_univ',
    ],

  }
}
