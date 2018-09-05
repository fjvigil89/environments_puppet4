#
#  Class icinga2_server
#================================
#

class icinga2_server {
  include ::monitoring::icinga2
  include ::monitoring::icingaweb2
class { '::basesys':
    uprinfo_usage      => 'icinga_server',
    application        => 'icinga',
    #puppet_enabled     => false,
    mta_enabled        => false,
    monitoring_enabled => false;
  }
}

