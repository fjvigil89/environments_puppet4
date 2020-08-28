#== Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache {
  class {'::filebeatserver':
    paths    => '/var/log/apache2/*.log',
    log_type => "apache",
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
     packages       =>  ['r10k','php7.0-mbstring','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common'],
  }

 





}
