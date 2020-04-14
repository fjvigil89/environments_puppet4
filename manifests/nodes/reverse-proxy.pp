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
      'www.upr.edu.cu',#1
      'correo.upr.edu.cu',#2
      'cvforestal.upr.edu.cu',#3
      'intranet.upr.edu.cu',#4      
      'nexus.upr.edu.cu',#6
      'harbor.upr.edu.cu',#7
      'proxy-go.upr.edu.cu',#8
      'gitlab.upr.edu.cu',#9
      'icingaweb.upr.edu.cu',#10
      'composer.upr.edu.cu',#11
      'cooder.upr.edu.cu',#13
      'mendive.upr.edu.cu',#15
      'podium.upr.edu.cu',#16
      'cfores.upr.edu.cu',#17
      'cifam.upr.edu.cu',#18 
      'coodes.upr.edu.cu',#19
      'rc.upr.edu.cu',#20
      'crai.upr.edu.cu',#21
      'blogcrai.upr.edu.cu',#22
      'revistaecovida.upr.edu.cu',#23
      'tocororo.upr.edu.cu',#24
      'eventos.upr.edu.cu',#25
      'telefonos.upr.edu.cu',#27
      'enlaces.upr.edu.cu',#28
      'ftp.upr.edu.cu',#29
      'media.upr.edu.cu',#30
      'catalogo.upr.edu.cu',#31
      'earchivos.upr.edu.cu',#32
      'moodle.ceces.upr.edu.cu',#33
      'moodlead.upr.edu.cu',#34
      'moodle.upr.edu.cu',#35
      'foreman.upr.edu.cu',#36
      'adaudit.upr.edu.cu',#37
      
    ],
    #                  1  -2 - 3- 4-  6- 7- 8 -  9-10-11-13-15-16-17-18-19-20-21-22-23-24-25-27-28-29-30-31-32-33,34,35,36 ,37
    listen_port    => [80,80, 80, 80, 80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,443,80],
    #                  1  -2 - 3-  4- -6 - 7 - 8 -9- 10-11-13-15-16-17-18-19-20-21-22-23-24-25--27-28-29-30-31-32,33,34,35,36 ,37
    ssl_port       => [80,443,443,443,443,443,443,80,80,80,80,80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,443,80],
    location_allow => [
      '*',#1
      '*',#2
      '*',#3
      'red_univ',#4      
      '*',#6
      '*',#7
      '*',#8
      '*',#9
      '*',#10
      'red_univ',#11      
      'red_univ',#13
      '*',#15
      '*',#16
      '*',#17
      '*',#18
      '*',#19
      '*',#20
      '*',#21
      '*',#22
      '*',#23
      '*',#24
      '*',#25
      '*',#27
      'red_univ',#28
      'red_univ',#29
      'red_univ',#30
      'red_univ',#31
      'red_univ',#32
      'cuba',#33
      '*',#34
      'cuba',#35
      'cuba',#36
      'cuba',#37
    ],

  }
}
