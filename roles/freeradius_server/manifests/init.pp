# Class: freeradius_server
# ===========================
#
# Full description of class freedaruis_server here.
#
class freeradius_server ( 
  Array[String] $package = $::freeradius_server::params::$package,
  String $conf_path      = $::freeradius_server::params::conf_path, 

)inherits freeradius_server::params {
  {'::freeradius_server::conf':;}
  package { $package:
    ensure => installed,
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
   packages       => ['php7.0-ldap','php7.0-mysql'],
 }
 include '::mysql::server'
 mysql::db { 'radius':
   user     => 'radius',
   password => 'freeradius.upr2k18',
   host     => 'localhost',
   grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
   sql      => "${conf_path}/mods-config/sql/main/mysql/schema.sql", 
 }
}
