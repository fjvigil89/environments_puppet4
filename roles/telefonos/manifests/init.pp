# Class: telefonos
# ===========================
#
class telefonos(
  Boolean $manage_repos     = false,
  String  $version          = $::php_server::params::verion,
  Array[String] $packages   = $::php_server::params::pachages,
  )inherits ::php_server::params {

  include git
  include vim

class { '::php_webserver':
  php_version    => $version,
  php_extensions => {
   'curl'     => {},
   'gd'       => {},
   'mysql'    => {},
   'ldap'     => {},
   'xml'      => {},
   'mbstring' => {},
   },
  manage_repos   => $manage_repos,
    packages       => $packages,
    }
  }
 #  exec {"a2enmod_php7":
 #     command => '/usr/bin/sudo a2enmod php7.0',
 #     }
 #  exec {"service_apache2_restart":
 #     command     => '/usr/bin/sudo service apache2 restart',
 #     refreshonly => true;
 #     }
