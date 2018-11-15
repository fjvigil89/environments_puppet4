#
# Class monitoring::icingaweb_db
#==================================
#
# Configure icingaweb2::icingaweb_db

class monitoring::icingaweb_db {
# Configure icingaweb2 MySQL  
include ::mysql::server
mysql::db { $monitoring::icingaweb2_dbname:
  user     =>  $monitoring::icingaweb2_dbuser,
  password =>  $monitoring::icingaweb2_dbpass,
  host     =>  $monitoring::icingaweb2_dbhost,
  grant    =>  ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER', 'REFERENCES'],
}

# Configure director DB
mysql::db { $monitoring::director_dbname:
  user     =>  $monitoring::director_dbuser,
  password =>  $monitoring::director_dbpass,
  host     =>  $monitoring::director_dbhost,
  grant    =>  ['ALL'],
}
}


