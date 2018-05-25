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
     packages => ['php7.1-mbstring','r10k'],#,'php7.1','php7.0-cli','php7.1-common','php7.1-curl','php7.1-intl','php7.1-ldap','php7.1-mysql','php7.1-sybase','libapache2-mod-php7.1','php7.1-mcrypt'],
  }


}
