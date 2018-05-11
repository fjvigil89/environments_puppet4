# class monitoring::icinga2
#
#============================
#
# Configure icinga2

class monitoring::icinga2 (
   $icinga2_dbuser   = 'icinga2',
   $icinga2_dbname   = 'icinga2',
   $icinga2_dbpass   = 'supersecret',
   $icinga2_dbhost   = '127.0.0.1',
   $director_apipass = '123456',
   $director_apiuser = 'director',
   $api_users = {},
) {


# Create a DB icinga2 (IDO)
include '::mysql::server'
mysql::db { 'icinga2':
  user     =>  $monitoring::icinga2::icinga2_dbuser,
  password =>  $monitoring::icinga2::icinga2_dbpass,
  host     =>  $monitoring::icinga2::icinga2_dbhost,
  grant    =>   ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
}
# Configure icinga2 
class { '::icinga2':
  confd         =>   false,
  manage_repo   =>   false,
  features      =>   ['checker','mainlog','notification','statusdata','compatlog','command'],
  constants     =>   {
    'ZoneName' =>   'master',
    'NodeName' =>   $facts['fqdn'],
    ticketsalt =>   '5a3d695b8aef8f18452fc494593056a4',
  },
}

# Configure ido_mysql
class { '::icinga2::feature::idomysql':
  user          => $monitoring::icinga2::icinga2_dbuser,
  password      => $monitoring::icinga2::icinga2_dbpass,
  host          => $monitoring::icinga2::icinga2_dbhost,
  database      => $monitoring::icinga2::icinga2_dbname,
  import_schema => true,
  require       => Mysql::Db[$monitoring::icinga2::icinga2_dbname],
}

# Configure API
class { '::icinga2::feature::api':
 accept_commands => true,
 accept_config   => false,
 endpoints       => {
  $facts['fqdn'] => {
    'host' =>  $facts['ipaddress'],
  }
},
zones           => {
  'master' => {
    'endpoints' =>  [$facts['fqdn']],
  } 
 }
}

icinga2::object::zone { 'global-templates':
  global =>  true,
}
icinga2::object::zone { 'director-global':
  global =>  true,
}

# UPR icinga2 Configuration

file { '/etc/icinga2/conf.d/app.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/app.conf',
  }

  file { '/etc/icinga2/conf.d/apt.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/apt.conf',
  }

  file { '/etc/icinga2/conf.d/commands.conf':
    ensure => file,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/commands.conf',
  }

  file { '/etc/icinga2/conf.d/downtimes.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/downtimes.conf',
  }

  file { '/etc/icinga2/conf.d/groups.conf':
    ensure => file,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/groups.conf',
  }

  file { '/etc/icinga2/conf.d/hosts.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/hosts.conf',
  }

  file { '/etc/icinga2/conf.d/notifications.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/notifications.conf',
  }

  file { '/etc/icinga2/conf.d/satellite.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/satellite.conf',
  }

  file { '/etc/icinga2/conf.d/services.conf':
    ensure => absent,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/services.conf',
  }

  file { '/etc/icinga2/conf.d/templates.conf':
    ensure => file,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/templates.conf',
  }

  file { '/etc/icinga2/conf.d/timeperiods.conf':
    ensure => file,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/timeperiods.conf',
  }

  file { '/etc/icinga2/conf.d/users.conf':
    ensure => file,
    tag    => 'icinga2::config::file',
    source => 'puppet:///modules/monitoring/confd/users.conf',
  }
 icinga2::object::host { $facts['fqdn']:
  display_name  => $facts['fqdn'],
  address       => $facts['ipaddress'],
  #address6      => '::1',
  check_command => 'hostalive',
  target        => '/etc/icinga2/conf.d/hosts-test.conf',
 }
 icinga2::object::service { 'SSH':
  target        => '/etc/icinga2/conf.d/test.conf',
  apply         => true,
  assign        => [ 'host.vars.os == Linux' ],
  ignore        => [ 'host.vars.os == Windows' ],
  display_name  => 'Test Service',
  check_command => 'ssh',
 }
 icinga2::object::hostgroup { 'monitoring-hosts':
  display_name => 'Linux Servers',
  groups       => [ 'linux-servers' ],
  target       => '/etc/icinga2/conf.d/groups2.conf',
  assign       => [ 'host.vars.os == "linux"' ],
}
}
