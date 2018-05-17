# == Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache {
 
 include git
 
 class {'::wh_php_apache::apache':;}

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
    packages => ['php7.0-mbstring','r10k'],
  }


}
