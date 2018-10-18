# class monitoring::icinga2_agent
#
#============================
#
# Configure icinga2_agent
#

class monitoring::icinga2_agent {
  include ::monitoring::params
  class {'::icinga2':
    manage_repo => $monitoring::manage_repo,
    features    => ['checker','mainlog'],
  }
  icinga2::object::zone { 'global-templates':
    global => true,
  }
  icinga2::object::zone { 'director-global':
    global => true,
  }
  include ::monitoring::checks
  class { '::icinga2::feature::api':
    pki             => 'puppet',
    accept_config   => true,
    accept_commands => true,
    endpoints       => {},
    zones           => {},
  }
  #Configure EndPoints
  icinga2::object::endpoint { $::fqdn:
    host => $::ipaddress,
  }
  each($::monitoring::icinga_servers) |Integer $index, String $value|{
    icinga2::object::endpoint { $::monitoring::icinga_servers[$index]:
      host => $::monitoring::icinga_ipservers[$index],
    }
  }
  #Configure Zones
  icinga2::object::zone { $::fqdn:
    endpoints => [ $fqdn ],
    parent    => 'master',
  }
  icinga2::object::zone { 'master':
    endpoints => $::monitoring::icinga_servers,
  }
}
