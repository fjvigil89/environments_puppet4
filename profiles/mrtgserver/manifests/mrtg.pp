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
  exec {'cfgmaker':
    creates => "/etc/mrtg/10.2.1.1.cfg",
    command => "/usr/bin/cfgmaker network4core@dminUPR@10.2.1.1 > /etc/mrtg/10.2.1.1.cfg"
  }
  cron {'indexmaker':
    user    => $owner,
    command => '/usr/bin/indexmaker --columns=2 --addhead="<H1 align= "center" > Multi Router Traffic Grapher <H1>" --title="Tr&aacute;fico de Enlaces UPR" /etc/mrtg/10.2.1.1.cfg --output=/var/www/mrtg/index.html',
    minute  => '*/1'
  }
}
