# == Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache {

  class { '::basesys':
    uprinfo_usage  => 'servidor test',
    application      => 'puppet',
    puppet_enabled   => false,
    mta_enabled => false,
    repos_enabled => false;
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
 
  cron{'sync_upr_NoDocentes':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/NoDocentes" > /var/log/sync_upr_NoDocentes.log',
    hour    => ['2'],
  }
  
  cron{'sync_upr_Docentes':
  ensure  => present,
  command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/Docentes" > /var/log/sync_upr_Docentes.log',
  hour    => ['3'],
  }
  cron{'sync_upr_Bajas':
  ensure  => present,
  command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/actualizar_bajas_profesores" > /var/log/sync_upr_Bajas.log',
  hour    => ['1'],
  }
 
  cron{'sync_upr_User_Bajas':
  ensure  => present,
  command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/Bajas" > /var/log/sync_upr_User_Bajas.log',
  hour    => ['4'],
  }
  
  cron{'sync_upr_Actualizar_OU':
  ensure  => present,
  command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/saber_ldap/Actualizar" > /var/log/sync_upr_User_Actualizar_OU.log',
  hour    => ['4'],
  }
  cron{'sync_upr_CrearUsuarios':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "https://sync.upr.edu.cu/actualizar_altas_profesores" > /var/log/sync_upr_CrearUsuario.log',
    hour    => [12,18],
  }
}
