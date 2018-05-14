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
  user     => $monitoring::icinga2::icinga2_dbuser,
  password => $monitoring::icinga2::icinga2_dbpass,
  host     => $monitoring::icinga2::icinga2_dbhost,
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
}
# Configure icinga2 
class { '::icinga2':
  confd       => false,
  manage_repo => false,
  features    => ['checker','mainlog','notification','statusdata','compatlog'],
  constants   => {
    'ZoneName' => 'master',
    'NodeName' => $facts['fqdn'],
    ticketsalt => '5a3d695b8aef8f18452fc494593056a4',
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
 accept_config   => true,
 pki             => 'puppet',
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
#Configure Command
class { '::icinga2::feature::command':
 ensure     => present,
 commandpath => '/var/run/icinga2/cmd/icinga2.cmd', 
}

icinga2::object::zone { 'global-templates':
  global =>  true,
}
icinga2::object::zone { 'director-global':
  global =>  true,
}
}
