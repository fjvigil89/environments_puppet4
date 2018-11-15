#
# Class monitoring::module_director
#==================================
#
# Configure monitoring::module_director

class monitoring::module_director {

#Configure Director Module
include git
class {'icingaweb2::module::director':
  git_revision  =>   'master',
  db_host       =>   $monitoring::director_dbhost,
  db_name       =>   $monitoring::director_dbname,
  db_username   =>   $monitoring::director_dbuser,
  db_password   =>   $monitoring::director_dbpass,
  import_schema =>   true,
  kickstart     =>   true,
  endpoint      =>   $facts['fqdn'],
  api_username  =>   $monitoring::director_apiuser,
  api_password  =>   $monitoring::director_apipass,
  require       =>   Mysql::Db[$monitoring::director_dbname],
}

#Director API user module
icinga2::object::apiuser { 'root':
  ensure      => present,
  password    => $monitoring::icinga2_dbpass,
  permissions => ['*'],
  target      => "${::icinga2::params::conf_dir}/features-available/api.conf",
}
icinga2::object::apiuser { 'director':
  ensure      => present,
  password    => $monitoring::director_apipass,
  permissions => ['*'],
  target      => "${::icinga2::params::conf_dir}/features-available/api.conf",
}

# Kick Director 
exec { 'Icinga Director Kickstart':
  path    => '/usr/local/bin:/usr/bin:/bin',
  command => 'icingacli director kickstart run',
  onlyif  => 'icingacli director kickstart required',
  require => Exec['Icinga Director DB migration'],
}
exec { 'Icinga Director DB migration':
  path    => '/usr/local/bin:/usr/bin:/bin',
  command => 'icingacli director migration run',
  onlyif  => 'icingacli director migration pending',
}
}


