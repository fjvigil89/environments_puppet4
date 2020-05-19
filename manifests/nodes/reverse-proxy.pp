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
      'nexus.upr.edu.cu',#5 
      'proxy-go.upr.edu.cu',#6 
      'gitlab.upr.edu.cu',#7 
      'icingaweb.upr.edu.cu',#8 
      'composer.upr.edu.cu',#9 
      'cooder.upr.edu.cu',#10 
      'mendive.upr.edu.cu',#11 
      'podium.upr.edu.cu',#12 
      'cfores.upr.edu.cu',#13 
      'cifam.upr.edu.cu',#14  
      'coodes.upr.edu.cu',#15 
      'rc.upr.edu.cu',#16 
      'revistaecovida.upr.edu.cu',#17 
      'eventos.upr.edu.cu',#18 
      'telefonos.upr.edu.cu',#19 
      'ftp.upr.edu.cu',#20 
      'media.upr.edu.cu',#21 
      'catalogo.upr.edu.cu',#22 
      'earchivos.upr.edu.cu',#23 
      'moodle.ceces.upr.edu.cu',#24 
      'moodlead.upr.edu.cu',#25 
      'moodle.upr.edu.cu',#26 
      'techobs.upr.edu.cu',#27 
      'sciobs.upr.edu.cu',#28 
      'coronavirus.upr.edu.cu',#29 
      'cadellab.upr.edu.cu', #30
      'news.upr.edu.cu', #31      
      
    ],
    #                  1 -2 -3- 4- 5- 6 - 7 -8 -9 -10-11-12-13-14-15-16-17-18-19-20-21-22-23-24,25,26,27,28,29,30, 31
    listen_port    => [80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80, 80],
    #                  1 -2 - 3  -4- 5 -6  -7 -8 -9 -10-11-12-13-14-15-16 -17-18-19-20-21-22-23,24,25,26,27 ,28 ,29,30, 31
    ssl_port       => [80,443,443,80,80,443,80,80,80,80,80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80,443,443,80,443, 80],
    location_allow => [
      '*',#1
      '*',#2
      '*',#3
      'red_univ',#4      
      '*',#5
      '*',#6
      '*',#7
      '*',#8
      'red_univ',#9
      '*',#10      
      '*',#11
      '*',#12
      '*',#13
      '*',#14
      '*',#15
      '*',#16
      '*',#17
      '*',#18
      'red_univ',#19
      'red_univ',#20
      'red_univ',#21
      '*',#22
      '*',#23
      'cuba',#24
      'cuba',#25
      'cuba',#26
      'cuba',#27
      'cuba',#28
      'cuba',#29
      'cuba', #30
      '*', #31
    ],

  }

}
