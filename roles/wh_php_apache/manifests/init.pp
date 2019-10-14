#== Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache {
  class {'::filebeatserver':
    paths    => '/var/log/apache2/*.log',
    log_type => "apache",
   }

  class { '::basesys':
    uprinfo_usage  => 'servidor test',
    application    => 'puppet',
    #puppet_enabled => false,
    mta_enabled    => false,
  }
  
 include git
 include vim
 #class {'::wh_php_apache::apache':;}

class { ::letsencrypt:
  unsafe_registration => true,
}

 class { '::php_webserver':
     php_version    => '7.0',
     php_extensions => {
      'curl'     => {},
      'gd'       => {},
      'mysql'    => {},
      'ldap'     => {},
      'xml'      => {},
      'mbstring' => {},
     },
     packages       =>  ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common'],
  }

 
  cron{'ActualizarLdap':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/saber_ldap" > /var/log/sync_upr',
    hour    => [2],
    minute  => 0,
  }
  
  cron{'ActualizarLosQueSonDeDI':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/upredes" > /var/log/sync_upr_UPRedes.log',
    hour    => 17,
    minute  => 0,
  }

  cron {'CrearLosNuevosEstudiantesDeIngreso':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/crear_student" > /var/log/sync_upr_newStudent.log',
    hour    => [23,20],
    minute  => 59,
  }
  cron {'CreacionTrabajadoresNuevos':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/crear_trabajador_mes" > /var/log/sync_upr_crear_trabajador_mes.log',
    hour    => [2,23],
    minute  => 0,
  }


class {'::serv_logrotate':
  compress         => true, 
  filelog_numbers  => [5,7],
  rotate_frecuency => ['week'],
  rule_list        => ['laravel', 'apache'],
  log_path         => ['/home/Sync-UPR/master/storage/logs/*.log', '/var/log/apache2/*.log'],
}

 file{'/etc/borraram.sh':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/wh_php_apache/borraram.sh',
  }->
 cron{'borrarram':
    ensure  => present,
    command => '/etc/borraram.sh',
    hour    => [1],
    minute  => 0,
  }



}
