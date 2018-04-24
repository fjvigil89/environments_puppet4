#
# Class monitoring::icingaweb2
#==================================
#
# Configure icingaweb2

class monitoring::icingaweb2 (
 $icingaweb2_dbuser = 'icingaweb2',
 $icingaweb2_dbname = 'icingaweb2',
 $icingaweb2_dbpass = 'icingaweb2',
 $icingaweb2_dbhost = 'localhost',

 $director_dbuser = 'director',
 $director_dbname = 'director',
 $director_dbpass = 'director',
 $director_dbhost = 'localhost',

 $ad_root_dn = 'CN=icinga2,OU=Servicios,DC=upr,DC=edu,DC=cu',
 $ad_bind_dn = 'icinga2',
 $ad_bind_pw = 'web.2k17',

 $director_apipass = '123456',
 $director_apiuser = 'director',

 $icinga2_dbuser = 'icinga2',
 $icinga2_dbname = 'icinga2',
 $icinga2_dbpass = 'supersecret',
 $icinga2_dbhost = 'localhost',

) {
# Configure icingaweb2 MySQL  
include ::mysql::server
mysql::db { $monitoring::icingaweb2::icingaweb2_dbname:
  user     =>  $monitoring::icingaweb2::icingaweb2_dbuser,
  password =>  $monitoring::icingaweb2::icingaweb2_dbpass,
  host     =>  $monitoring::icingaweb2::icingaweb2_dbhost,
  grant    =>  ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER', 'REFERENCES'],
}

# Configure director DB
mysql::db { $monitoring::icingaweb2::director_dbname:
  user     =>  $monitoring::icingaweb2::director_dbuser,
  password =>  $monitoring::icingaweb2::director_dbpass,
  host     =>  $monitoring::icingaweb2::director_dbhost,
  grant    =>  ['ALL'],
}

# Configure icingaweb2
class {'::icingaweb2':
  manage_package =>  true,
  import_schema  =>  true,
  logging        =>  'syslog',
  db_type        =>  'mysql',
  db_host        =>  $monitoring::icingaweb2::icingaweb2_dbhost,
  db_username    =>  $monitoring::icingaweb2::icingaweb2_dbuser,
  db_password    =>  $icingaweb2_dbpass,
  require        =>  Mysql::Db[$monitoring::icingaweb2::icingaweb2_dbname],
}

#Configure Resourse Authentication
icingaweb2::config::resource{'ad-upr':
  type            =>  'ldap',
  host            =>  'ad.upr.edu.cu',
  port            =>  389,
  ldap_root_dn    =>  $monitoring::icingaweb2::ad_root_dn,
  ldap_bind_dn    =>  $monitoring::icingaweb2::ad_bind_dn,
  ldap_bind_pw    =>  $monitoring::icingaweb2::ad_bind_pw,
  ldap_encryption =>  'none',
}

# Configure Autentication Method
icingaweb2::config::authmethod {'ad-auth':
  backend  =>  'msldap',
  resource =>  'ad-upr',
  order    =>  '03',
}

#Configure Doc Module
include ::icingaweb2::module::doc

#Configure Director Module
include git
class {'icingaweb2::module::director':
  git_revision  =>   'master',
  db_host       =>   $monitoring::icingaweb2::director_dbhost,
  db_name       =>   $monitoring::icingaweb2::director_dbname,
  db_username   =>   $monitoring::icingaweb2::director_dbuser,
  db_password   =>   $monitoring::icingaweb2::director_dbpass,
  import_schema =>   true,
  kickstart     =>   true,
  endpoint      =>   $facts['fqdn'],
  api_username  =>   $monitoring::icingaweb2::director_apiuser,
  api_password  =>   $monitoring::icingaweb2::director_apipass,
  require       =>   Mysql::Db[$monitoring::icingaweb2::director_dbname],
}

#Director API user module
icinga2::object::apiuser { 'root':
  ensure      =>  present,
  password    =>  $monitoring::icingaweb2::director_apipass,
  permissions =>  ['*'],
  target      =>  "${::icinga2::params::conf_dir}/features-available/api.conf",
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

# Configure Monitoring Module
class {'icingaweb2::module::monitoring':
  ido_host          => $monitoring::icingaweb2::icinga2_dbhost,
  ido_db_name       => $monitoring::icingaweb2::icinga2_dbname,
  ido_db_username   => $monitoring::icingaweb2::icinga2_dbuser,
  ido_db_password   => $monitoring::icingaweb2::icinga2_dbpass,
  commandtransports => {
    icinga2 => {
      transport => 'api',
      username  => $monitoring::icingaweb2::icinga2_dbuser,
      password  => $monitoring::icingaweb2::icinga2_dbpass,
    }
  }
}

#PuppetDB Icingaweb2 Module
include ::icingaweb2::module::puppetdb
$puppetdb_host    = 'puppetdb.upr.edu.cu'
$my_certname      = 'puppetdb.upr.edu.cu'
$ssldir           = '/etc/puppetlabs/puppet/ssl'
$web_ssldir       = '/etc/icingaweb2/modules/puppetdb/ssl'
$ssl_subdir       = "${web_ssldir}/${puppetdb_host}"
$private_keys_dir = '/etc/icingaweb2/modules/puppetdb/ssl/puppetdb.upr.edu.cu/private_keys'
$certs_dir        = '/etc/icingaweb2/modules/puppetdb/ssl/puppetdb.upr.edu.cu/certs'

file { $ssl_subdir:
  ensure =>   directory,
  source =>   $ssldir,
  recurse =>   true,
}
exec { "Generate combined .pem file for ${puppetdb_host}":
  command     =>   "cat ${private_keys_dir}/${my_certname}.pem ${certs_dir}/${my_certname}.pem > ${private_keys_dir}/${my_certname}_combined.pem",
  path        =>   ['/usr/bin', '/usr/sbin'],
  cwd         =>   $ssl_subdir,
  refreshonly =>   true
}

include ::apache

#class { '::php::globals':
#  php_version =>  '7.0',
#  config_root =>  '/etc/php/7.0',
#}
#class { '::php':
#  manage_repos =>  true
#}

#include ::apache::mod::php
#class roles::webserver::service::website () {

#include roles::webserver::apache
apache::vhost { 'icingaweb.upr.edu.cu':
  servername      => 'icingaweb.upr.edu.cu',
  port            => '80',
  docroot         => '/usr/share/icingaweb2/public',
#  redirect_status => 'permanent',
#  redirect_dest   => "http://icingaweb.upr.edu.cu",
}
#}
#file_line{ 'date.timezone':
#  path   => '/etc/php5/apache2/php.ini',
#  line   => 'date.timezone = America/Havana',
#  match  => '^date.timezone =',
#  notify =>  Class['apache'],
#}
}


