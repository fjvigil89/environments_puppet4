# Class: freeradius_server
# ===========================
#
# Full description of class freedaruis_server here.
#
class freeradius_server {
$package = ['freeradius', 'freeradius-mysql','freeradius-utils']
$conf_path = '/etc/freeradius/3.0'
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
file { '/usr/share/ad-to-pap.php': 
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0774',
  source => 'puppet:///modules/freeradius_server/sync/ad-to-pap.php',
}
cron{'sync_ad_pap':
  ensure  => present,
  command => 'php /usr/share/ad-to-pap.php >> /var/log/sync_ad_pap.log',
  hour    => ['0','12','17'],
}


}
