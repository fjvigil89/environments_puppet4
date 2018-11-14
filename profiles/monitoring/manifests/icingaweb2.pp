#
# Class monitoring::icingaweb2
#==================================
#
# Configure icingaweb2

class monitoring::icingaweb2 {
# Configure icingaweb2 MySQL DBs 
class {'::monitoring::icingaweb_db':;}
# Configure icingaweb2
class {'::icingaweb2':
  manage_package => true,
  import_schema  => true,
  logging        => 'syslog',
  db_type        => 'mysql',
  db_host        => $monitoring::icingaweb2_dbhost,
  db_username    => $monitoring::icingaweb2_dbuser,
  db_password    => $monitoring::icingaweb2_dbpass,
  require        => Mysql::Db[$monitoring::icingaweb2_dbname],
}

#Resourse Authentication
class {'::monitoring::icingaweb_auth':;}
#Configure Doc Module
include ::icingaweb2::module::doc
#Director Module
class {'::monitoring::module_director':;}
# Configure Monitoring Module
class {'::monitoring::module_monitoring':;}
#PuppetDB Icingaweb2 Module
class {'::monitoring::module_puppetdb':;}
#Installing apache or httpd
class {'::monitoring::icingaweb_web':;}
#Graphite Module
class { 'icingaweb2::module::graphite':
  git_revision => 'v1.1.0',
  url          => 'http://graphite.upr.edu.cu'
}
#Fileshippet Module
class { 'icingaweb2::module::fileshipper':
  git_revision     => 'master',
  base_directories => {
    basedir => '/var/cache/icinga2',
  },
  directories      => {
    'test' => {
      'source'     => '/usr/local/src/custom-rules.git',
      'target'     => '/zones.d/director-global/custom-rules',
      'extensions' => '.conf, .md',
    }
  }
}
# Cube Module
class { 'icingaweb2::module::cube':
  git_revision => 'v1.0.0'
}
class {'::monitoring::module_fileshipper':;}

}


