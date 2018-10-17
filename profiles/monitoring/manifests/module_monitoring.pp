#
# Class monitoring::module_monitoring
#==================================
#
# Configure monitoring::module_monitoring

class monitoring::module_monitoring {
# Configure Monitoring Module
class {'icingaweb2::module::monitoring':
  ido_host          => $monitoring::icinga2_dbhost,
  ido_db_name       => $monitoring::icinga2_dbname,
  ido_db_username   => $monitoring::icinga2_dbuser,
  ido_db_password   => $monitoring::icinga2_dbpass,
  commandtransports => {
    icinga2 => {
      transport => 'api',
      username  => 'root',
      password  => $monitoring::icinga2_dbpass,
    }
  }
}
}


