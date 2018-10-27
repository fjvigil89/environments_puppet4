# == Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache {

  class { '::basesys':
    uprinfo_usage  => 'servidor test',
    application    => 'puppet',
    #puppet_enabled => false,
    mta_enabled    => false,
  }
  
 include git
 include vim
 #class {'::wh_php_apache::apache':;}

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
 
  cron{'ActualizaLosNoDocentes':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/NoDocentes" > /var/log/sync_upr_NoDocentes.log',
    hour    => '14',
    minute  => 0,
  }
  
  cron{'ActualizarDocentes':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/Docentes" > /var/log/sync_upr_Docentes.log',
    hour    => '15',
    minute  => 0,
  }
  cron{'ActualizarLosProfesoresQueSonBajasHoy':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/actualizar_bajas_profesores" > /var/log/sync_upr_Bajas.log',
    hour    => '13',
    minute  => 0,
  }
 
  cron{'ActualizarLosQueDejaronDeSerBajasHoy':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/Bajas" > /var/log/sync_upr_User_Bajas.log',
    hour    => '16',
    minute  => 0,
  }
  
  cron{'CrearTrabajadoresQueSonAltaHoy':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/actualizar_altas_profesores" > /var/log/sync_upr_CrearUsuario.log',
    hour    => [12,18],
    minute  => 0,
  }
  cron{'ActualizarLosQueSonDeDI':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/upredes" > /var/log/sync_upr_UPRedes.log',
    hour    => 17,
    minute  => 0,
  }

  cron{'ActualizarLosEstudiantes':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap_student" > /var/log/sync_upr_Student.log',
    hour    => 21,
    minute  => 0,
  }

  cron {'CrearLosNuevosEstudiantesDeIngreso':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/crear_student" > /var/log/sync_upr_newStudent.log',
    hour    => 20,
    minute  => 0,
  }

 cron {'ADDGrupoPasswordAlosCompanerosDeSoftUPR':
   ensure  => present,
   command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/password/ADD" > /var/log/sync_upr_GrupoPassword.log',
   hour    => 11,
   minute  => 0,
 }

 cron {'REMOVEGrupoPasswordAlosCompanerosDeSftUPR':
   ensure  => present,
   command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/password/REMOVE" > /var/log/sync_upr_GrupoPassword.log',
   hour    => 15,
   minute  => 0,
 }

class {'::serv_logrotate':
  compress         => true, 
  filelog_numbers  => [5,7],
  rotate_frecuency => ['week'],
  rule_list        => ['laravel', 'apache'],
  log_path         => ['/home/Sync-UPR/master/storage/logs/*.log', '/var/log/apache2/*.log'],
}

}
