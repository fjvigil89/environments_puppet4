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
      'cooder.upr.edu.cu',#12
      'mendive.upr.edu.cu',#13
      'podium.upr.edu.cu',#14
      'cfores.upr.edu.cu',#15
      'cifam.upr.edu.cu',#16 
      'coodes.upr.edu.cu',#17
      'rc.upr.edu.cu',#18
      'revistaecovida.upr.edu.cu',#19
      'eventos.upr.edu.cu',#20
      'telefonos.upr.edu.cu',#21
      'enlaces.upr.edu.cu',#22
      'ftp.upr.edu.cu',#23
      'media.upr.edu.cu',#24
      'catalogo.upr.edu.cu',#25
      'earchivos.upr.edu.cu',#26
      'moodle.ceces.upr.edu.cu',#27
      'moodleed.upr.edu.cu',#28
      'ceces.upr.edu.cu', #29
      'noticias.upr.edu.cu', #30
      'techobs.upr.edu.cu',#31
      'sciobs.upr.edu.cu',#32
      'coronavirus.upr.edu.cu',#33
      'cadellab.upr.edu.cu', #34
      'magnum.upr.edu.cu', #35
      'coronavirus2.upr.edu.cu',#36
      'pinarcti.upr.edu.cu',#37
      'gicacovid.upr.edu.cu',#38
    ],
    #                  1  -2 - 3 - 4 - 6- 7 - 8 - 9--10-11-12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27,28, 29, 30, 31, 32, 33, 34, 35   36, 37, 38
    listen_port    => [80,80 ,80 , 80, 80,80 ,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80, 80, 80, 80, 80, 80, 443, 80, 80, 80, 80],
    #                  1  -2 - 3-  4- -6 - 7 - 8 -9- 10-11-12-13-14-15-16-17-18 -19-20-21-22-23-24-25-26,27,28, 29, 30, 31, 32, 33, 34, 35  36, 37, 38
    ssl_port       => [443,443,443,443,443,443,443,80,80,80,80,80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80, 80, 80, 443,443,80, 443, 80,443,80, 80],
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
      '*',#12
      '*',#13
      '*',#14
      '*',#15
      '*',#16
      '*',#17
      '*',#18
      '*',#19
      '*',#20
      'cuba',#21
      'cuba',#22
      'cuba',#23
      'red_univ',#24
      'red_univ',#25
      'red_univ',#26
      '*',#27
      '*',#28
      '*',#29
      '*',#30
      '*',#31
      '*',#32
      '*',#33
      '*', #34
      '*', #35
      '*', #36
      '*', #37
      '*', #38
    ],

  }

}
