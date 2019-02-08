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
  each($::mrtgserver::ip) |Integer $index, String $value|{
    exec { $value :
      creates => "/etc/mrtg/${value}.cfg",
      command => "/usr/bin/cfgmaker network4core@dminUPR@$value > /etc/mrtg/$value.cfg"
    }
  }
  cron {'indexmaker':
    user    => $owner,
    command => '/usr/bin/indexmaker --columns=2 --addhead="<H1 align= "center" > Multi Router Traffic Grapher <H1>" --title="Tr&aacute;fico de Enlaces UPR" /etc/mrtg/10.2.1.1.cfg /etc/mrtg/192.168.200.1.cfg /etc/mrtg/10.2.8.2.cfg > /var/www/mrtg/index.html',
    minute  => '*/1'
  }
  file { '/etc/prueba':
    source => "/etc/puppetlabs/code/environments/henry/profiles/mrtgserver/manifests/mrtg.pp"
  }
}
  #Agregar en /etc/cron.d/mrtg:
  #  */1 * * * *   root   env LANG=C /usr/bin/mrtg /etc/mrtg/10.2.1.1.cfg 2> /dev/null&
  #  */1 * * * *   root   env LANG=C /usr/bin/mrtg /etc/mrtg/10.2.8.2.cfg 2> /dev/null&
  #  */1 * * * *   root   env LANG=C /usr/bin/mrtg /etc/mrtg/192.168.200.1.cfg 2> /dev/null&
