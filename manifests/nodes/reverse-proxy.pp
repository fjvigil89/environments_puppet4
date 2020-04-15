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
      'www.upr.edu.cu',#1 80
      'correo.upr.edu.cu',#2 443
      'cvforestal.upr.edu.cu',#3 443 
      'intranet.upr.edu.cu',#4 80     
      'nexus.upr.edu.cu',#5 80
      'proxy-go.upr.edu.cu',#6 443
      'gitlab.upr.edu.cu',#7 80
      'icingaweb.upr.edu.cu',#8 80
      'composer.upr.edu.cu',#9 80
      'cooder.upr.edu.cu',#10 80
      'mendive.upr.edu.cu',#11 80
      'podium.upr.edu.cu',#12 80
      'cfores.upr.edu.cu',#13 80
      'cifam.upr.edu.cu',#14 80 
      'coodes.upr.edu.cu',#15 80
      'rc.upr.edu.cu',#16 80
      'revistaecovida.upr.edu.cu',#17 80
      'eventos.upr.edu.cu',#18 80
      'telefonos.upr.edu.cu',#19 80
      'ftp.upr.edu.cu',#20 80
      'media.upr.edu.cu',#21 80
      'catalogo.upr.edu.cu',#22 80
      'earchivos.upr.edu.cu',#23 80
      'moodle.ceces.upr.edu.cu',#24 80
      'moodlead.upr.edu.cu',#25 80
      'moodle.upr.edu.cu',#26 80
      'techobs.upr.edu.cu',#27 443
      'sciobs.upr.edu.cu',#28 443
      'coronavirus.upr.edu.cu',#29 80
      'cadellab.upr.edu.cu', #30
      
    ],
    #                  1 -2  - 3- 4 - 5- 6 -7 -8 -9 -10-11-12-13-14-15-16-17-18-19-20-21-22-23-24,25,26,27,28,29,30
    listen_port    => [80,443,80, 80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,443],
    #                  1 -2 - 3  -4- 5 -6  -7 -8 -9 -10-11-12-13-14-15-16 -17-18-19-20-21-22-23,24,25,26,27 ,28 ,29,30
    ssl_port       => [80,443,443,80,80,443,80,80,80,80,80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80,443,443,80,443],
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
    ],

  }

}
