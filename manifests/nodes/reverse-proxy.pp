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
      'lwww.upr.edu.cu',#1 80
      'lcorreo.upr.edu.cu',#2 443
      'lcvforestal.upr.edu.cu',#3 443 
      'lintranet.upr.edu.cu',#4 80     
      'lnexus.upr.edu.cu',#5 80
      'lproxy-go.upr.edu.cu',#6 443
      'lgitlab.upr.edu.cu',#7 80
      'licingaweb.upr.edu.cu',#8 80
      'lcomposer.upr.edu.cu',#9 80
      'lcooder.upr.edu.cu',#10 80
      'lmendive.upr.edu.cu',#11 80
      'lpodium.upr.edu.cu',#12 80
      'lcfores.upr.edu.cu',#13 80
      'lcifam.upr.edu.cu',#14 80 
      'lcoodes.upr.edu.cu',#15 80
      'lrc.upr.edu.cu',#16 80
      'lrevistaecovida.upr.edu.cu',#17 80
      'leventos.upr.edu.cu',#18 80
      'ltelefonos.upr.edu.cu',#19 80
      'lftp.upr.edu.cu',#20 80
      'lmedia.upr.edu.cu',#21 80
      'lcatalogo.upr.edu.cu',#22 80
      'learchivos.upr.edu.cu',#23 80
      'lmoodle.ceces.upr.edu.cu',#24 80
      'lmoodlead.upr.edu.cu',#25 80
      'lmoodle.upr.edu.cu',#26 80
      'ltechobs.upr.edu.cu',#27 443
      'lsciobs.upr.edu.cu',#28 443
      'lcoronavirus.upr.edu.cu',#29 80
      
    ],
    #                  1 -2  - 3- 4 - 5- 6 -7 -8 -9 -10-11-12-13-14-15-16-17-18-19-20-21-22-23-24,25,26,27,28,29
    listen_port    => [80,443,80, 80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
    #                  1 -2 - 3  -4- 5 -6  -7 -8 -9 -10-11-12-13-14-15-16 -17-18-19-20-21-22-23,24,25,26,27 ,28 ,29
    ssl_port       => [80,443,443,80,80,443,80,80,80,80,80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80,443,443,80],
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
    ],

  }
}
