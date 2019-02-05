#Clase MRTG

class mrtgserver::mrtg(){
  package { 'mrtg':
    ensure => installed,
  }
  file { '/var/www/mrtg':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
  exec {'primero':
    creates => "/etc/mrtg/10.2.1.1.cfg",
    command => "/usr/bin/cfgmaker network4core@dminUPR@10.2.1.1 > /etc/mrtg/10.2.1.1.cfg"
  }
  exec {'segundo':
    creates => "/etc/mrtg/segundo.cfg",
    command => "/usr/bin/cfgmaker network4core@dminUPR@10.2.1.1 > /etc/mrtg/segundo.cfg"
  }

  cron {'indexmaker':
    user    => $owner,
    command => '/usr/bin/indexmaker --columns=2 --addhead="<H1 align= "center" > Multi Router Traffic Grapher <H1>" --title="Tr&aacute;fico de Enlaces UPR" /etc/mrtg/10.2.1.1.cfg > /var/www/mrtg/index.html',
    minute  => '*/1'
  }
}

#each($::mrtgserver::ip) |Integer $index|{
#  exec {$::mrtgserver::name[$value]:
#  creates => "/etc/mrtg/$::mrtgserver::name[$value]",
#  command => "/usr/bin/cfgmaker network4core@dminUPR@$::mrtgserver::ip[$value] > /etc/mrtg/$::mrtgserver::name[$value].cfg"
#}}
