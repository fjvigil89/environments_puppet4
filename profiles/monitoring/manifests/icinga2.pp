# class monitoring::icinga2
#
#============================
#
# Configure icinga2

class monitoring::icinga2 {
# Create a DB icinga2 (IDO)
include '::mysql::server'
mysql::db { 'icinga2':
  user     => $monitoring::icinga2_dbuser,
  password => $monitoring::icinga2_dbpass,
  host     => $monitoring::icinga2_dbhost,
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
}

file { '/etc/icinga2/conf.d':
  ensure  => directory,
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  purge   => true,
  recurse => true,
}

# Configure icinga2 
class { '::icinga2':
  confd       => true,
  manage_repo => false,
  features    => ['checker','mainlog','notification','statusdata','compatlog'],
  constants   => {
    #'ZoneName' => 'master',
    #'NodeName' => $facts['fqdn'],
    ticketsalt => '5a3d695b8aef8f18452fc494593056a4',
  },
}

# Configure ido_mysql
class { '::icinga2::feature::idomysql':
  user          => $monitoring::icinga2_dbuser,
  password      => $monitoring::icinga2_dbpass,
  host          => $monitoring::icinga2_dbhost,
  database      => $monitoring::icinga2_dbname,
  import_schema => true,
  require       => Mysql::Db[$monitoring::icinga2_dbname],
}

class { '::icinga2::feature::api':
  accept_commands => true,
  accept_config   => true,
  pki             => 'puppet',
  endpoints       => {},
  zones           => {},
}
icinga2::object::apiuser { 'aNag':
  apiuser_name => 'arian',
  password     => 'icingaweb',
  permissions  => ["*"],
  target       => '/etc/icinga2/conf.d/apiuser.conf',
}
#Configure EndPoints
each($::monitoring::icinga_servers) |Integer $index, String $value|{
icinga2::object::endpoint { $::monitoring::icinga_servers[$index]:
  host => $::monitoring::icinga_ipservers[$index],
}
}
#Configure Zones
icinga2::object::zone { 'master':
  endpoints => $::monitoring::icinga_servers,
}
icinga2::object::apiuser { 'aNag':
  apiuser_name => 'icinga',
  password     => 'icingaweb',
  permissions  => ["*"],
  target       => '/etc/icinga2/conf.d/apiuser.conf',
}

#Configure Command
include ::icinga2::feature::command
#Configure livestatus
include ::icinga2::feature::livestatus

icinga2::object::zone { 'global-templates':
  global =>  true,
}
icinga2::object::zone { 'director-global':
  global =>  true,
}

#Graphite Feature Conf
class { '::icinga2::feature::graphite':
  host                   => '10.2.1.46',
  port                   => 2003,
  enable_send_thresholds => true,
  enable_send_metadata   => true,
}

}
