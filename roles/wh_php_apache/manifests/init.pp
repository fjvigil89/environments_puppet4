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
     packages       =>  ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin'],
  }
 
  exec{"change_php5_to_php7":
  ensure => present,
  command => 'a2enmod php7.0',
  }
 
  exec{"restart_apache2":
  ensure => present,
  command => 'service apache2 restart',
  }

}
