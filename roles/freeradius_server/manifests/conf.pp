# Class: freeradius_server::conf
# ===========================
#
# Full description of class freedaruis_server::conf here.
#
class freeradius_server::conf { 
  file {"${::freeradius_server::params::conf_path}/mods-enabled/sql":
    ensure => 'link',
    target => "${::freeradius_server::params::conf_path}/mods-available/sql",
  }
  file { "${::freeradius_server::params::conf_path}/sites-available/default":
    ensure => file,
    owner  => 'freerad',
    group  => 'freerad',
    mode   => '0640',
    source => 'puppet:///modules/freeradius_server/conf/default',
  }
  file { "${$::freeradius_server::params::conf_path}/mods-available/sql":
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
