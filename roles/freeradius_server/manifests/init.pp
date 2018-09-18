# Class: freeradius_server
# ===========================
#
# Full description of class freedaruis_server here.
#
class freeradius_server {
$package = ['freeradius', 'freeradius-mysql','freeradius-utils'],
$conf_path = '/etc/freeradius/3.0',
 package { $package:
ensure => installed,
}
include '::mysql::server'
mysql::db { 'radius':
user     => 'root',
password => 'freeradius.upr2k18',
host     => 'localhost',
grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
sql      => "${conf_path}/mods-config/sql/main/mysql/schema.sql",
 }
 file {"$conf_path/mods-enabled/sql":
ensure => 'link',
target => "${conf_path}/mods-available/sql",
}
file { "${conf_path}/sites-available/default":
ensure => file,
owner  => 'freerad',
group  => 'freerad',
mode   => '0640',
source => 'puppet:///modules/freeradius_server/conf/default',
}
file { "${conf_path}/mods-available/sql":
ensure => file,
owner  => 'freerad',
group  => 'freerad',
mode   => '0640',
source => 'puppet:///modules/freeradius_server/conf/sql',
}


}
