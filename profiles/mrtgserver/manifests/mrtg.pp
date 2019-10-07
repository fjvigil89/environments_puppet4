#Clase MRTG

class mrtgserver::mrtg(){
  package { 'mrtg':
    ensure => installed,
  }
  file {'/etc/mrtg':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
  file { '/var/www/mrtg':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  file { '/var/www/mrtg/sensores':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  file { '/var/www/mrtg/videoconferencia':
    ensure => directory,
	  owner  => $owner,
	  group  => $group,
	  mode   => $mode,
  }

  #exec { '10.2.0.2':
  #creates => "/etc/mrtg/10.2.0.2.cfg",
  #command => "/usr/bin/cfgmaker network4core@dminUPR@10.2.0.2 > /etc/mrtg/10.2.0.2.cfg"
  #}
  ######## GENERACIÓN DE LOS ARCHIVOS .CFG ########
  #  each($::mrtgserver::ip) |Integer $index, String $value|{
  #  exec { $value :
  #    creates => "/etc/mrtg/${value}.cfg",
  #    command => "/usr/bin/cfgmaker network4core@dminUPR@$value > /etc/mrtg/$value.cfg"
  #  }
  #}

  ######## COPIA DE LOS ARCHIVOS .CFG PREVIAMENTE GENERADOS Y EDITADOS ########

  ####DISPOSITIVOS####

  /* file { '/etc/mrtg/10.2.1.1.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/10.2.1.1.cfg',
  } */

  /* file { '/etc/mrtg/10.2.8.2.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/10.2.8.2.cfg',
  } */

  file { '/etc/mrtg/192.168.200.1.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/192.168.200.1.cfg',
  }

  file { '/etc/mrtg/10.2.0.2.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/10.2.0.2.cfg',
  }

  /* file { '/etc/mrtg/10.2.8.4.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/10.2.8.4.cfg',
  } */

  ####SENSORES####

  file { '/etc/mrtg/mrtg.sensor1.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/mrtg.sensor1.cfg',
  }

  file { '/etc/mrtg/mrtg.sensor2.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mrtgserver/mrtg.sensor2.cfg',
  }
  
  ######## GENERACIÓN DE LOS ARCHIVOS INDEX ########

  cron {'indexmaker_device':
    user    => $owner,
    command => 'indexmaker --columns=2 --addhead="<H1 align= "center" > Multi Router Traffic Grapher <H1>" --title="Tr&aacute;fico de Enlaces UPR" /etc/mrtg/192.168.200.1.cfg /etc/mrtg/10.2.1.1.cfg /etc/mrtg/10.2.8.2.cfg /etc/mrtg/10.2.0.2.cfg > /var/www/mrtg/index.html',
    minute  => '*/1'
  }

  cron {'indexmaker_sensores':
    user    => $owner,
    command => 'indexmaker --columns=2 --title="Temperatura y Humedad DATACENTER-UPR" /etc/mrtg/mrtg.sensor1.cfg /etc/mrtg/mrtg.sensor2.cfg > /var/www/mrtg/sensores/index.html',
    minute  => '*/1'
  }
#2> /dev/null&
  /* cron {'indexmaker_videoconferencia':
    user    => $owner,
	  command => '/usr/bin/indexmaker --columns=2 --title="Video Conferencia UPR" /etc/mrtg/10.2.8.4.cfg /var/www/mrtg/videoconferencia/index.html',
	  minute  => '1'/*
  } */
}
  #Agregar en /etc/cron.d/mrtg:
  #  */1 * * * *   root   env LANG=C /usr/bin/mrtg /etc/mrtg/10.2.1.1.cfg 2> /dev/null&
  #  */1 * * * *   root   env LANG=C /usr/bin/mrtg /etc/mrtg/10.2.8.2.cfg 2> /dev/null&
  #  */1 * * * *   root   env LANG=C /usr/bin/mrtg /etc/mrtg/192.168.200.1.cfg 2> /dev/null&
