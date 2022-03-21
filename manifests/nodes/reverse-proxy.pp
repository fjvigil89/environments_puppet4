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
      'teleclases.upr.edu.cu',#39
      'cneuro.upr.edu.cu',#40
      'estudiantes.upr.edu.cu',#41
      'moodle.upr.edu.cu',#42
      'ftp-notas.upr.edu.cu',#43
      'ftp-facultades.upr.edu.cu',#44
      'aulas-virtuales.upr.edu.cu',#45
      'tunota.upr.edu.cu',#46
      'videos.upr.edu.cu',#47
      'infosaen.upr.edu.cu',#48
      'repoinfo.upr.edu.cu',#49
      'repogeo.upr.edu.cu',#50
      'mecarepo.upr.edu.cu',#51
      'telecom.upr.edu.cu',#52
      'repofores.upr.edu.cu',#53
      'repoagro.upr.edu.cu',#54
      'sigenu.upr.edu.cu',#55
      'repoder.upr.edu.cu',#56
      'reposcult.upr.edu.cu',#57
      'repolext.upr.edu.cu',#58
      'repoedlab.upr.edu.cu',#59
      'repoelectrica.upr.edu.cu',#60
      'repo-fcf.upr.edu.cu',#61
      'repo-fem.upr.edu.cu',#62 
      'repo-fei.upr.edu.cu',#63 
      'repoeco.upr.edu.cu',#64 
      'repocont.upr.edu.cu',#65 
      'repoind.upr.edu.cu',#66 
      'educa.upr.edu.cu',#67
      'repoidiomas.upr.edu.cu',#68
      'acreditacion.upr.edu.cu',#69 
      'acreditacion2.upr.edu.cu',#70
      'repofisica.upr.edu.cu',#71
      'acreditacion-cegesta.upr.edu.cu',#72
      'acreditacion-forestal.upr.edu.cu',#73
      'gradocientifico.upr.edu.cu',#74
      'univ2022.upr.edu.cu',#75
      'premioscti.upr.edu.cu',#76
      'full.upr.edu.cu',#77
      'repo-full.upr.edu.cu',#78
      'premiosmerito.upr.edu.cu',#79
    ],
    #                  1  -2 - 3 - 4 - 6- 7 - 8 - 9--10-11-12-13-14-15-16-17-18-19-20-21-22-24-25-26-27,28, 29, 30, 31, 32, 33, 34, 35   36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
    listen_port    => [80,80 ,80 , 80, 80,80 ,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80, 80, 80, 80, 80, 80, 443, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
    #                  1  -2 - 3-  4- -6 - 7 - 8 -9- 10-11-12-13-14-15-16-17-18 -19-20-21-22--24-25-26,27,28, 29, 30, 31, 32, 33, 34, 35  36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47  48 49  50  51  52  53  54   55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
    ssl_port       => [443,443,443,443,443,443,443,80,80,80,80,80,80,80,80,80,443,80,80,80,80,80,80,80,80,80,80,443,443,443,80, 443, 80,443,80, 80, 80, 443, 443, 80,80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 443, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
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
      'cuba', #39
      '*', #40
      '*', #41
      'cuba', #42
      'cuba', #43
      'cuba', #44
      'cuba', #45
      'cuba', #46
      'cuba', #47
      'cuba', #48
      'cuba', #49
      'cuba', #50
      'cuba', #51
      'cuba', #52
      'cuba', #53
      'cuba', #54
      'cuba', #55
      'cuba', #56
      'cuba', #57
      'cuba', #58
      'cuba', #59
      'cuba', #60
      'cuba', #61
      'cuba', #62
      'cuba', #63
      'cuba', #64
      'cuba', #65
      'cuba', #66
      'cuba', #67
      'cuba', #68
      'cuba', #69
      'cuba', #70
      'cuba', #71
      'cuba', #72
      'cuba', #73
      'cuba', #74
      'cuba', #75
      'cuba', #76
      'cuba', #77
      'cuba', #78
      'cuba', #79
    ],

  }

}
