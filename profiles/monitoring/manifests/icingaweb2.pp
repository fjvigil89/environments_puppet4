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
  #logging        =>  'syslog',
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

}

