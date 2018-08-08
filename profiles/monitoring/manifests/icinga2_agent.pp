# class monitoring::icinga2_agent
#
#============================
#
# Configure icinga2_agent
#

class monitoring::icinga2_agent(
  $manage_repo = false,
) {
  class {'::icinga2':
    manage_repo => $manage_repo,
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
    endpoints       =>  {},
    zones           =>  {},
  }
  icinga2::object::endpoint { $::fqdn:
    host => $::ipaddress,
  }
  icinga2::object::zone { $::fqdn:
    endpoints => [ $fqdn ],
    parent    => 'master',
  }

  icinga2::object::endpoint { 'master-icinga0.upr.edu.cu':
    host => '10.2.1.49',
  }
  icinga2::object::zone { 'master':
    endpoints => [ 'master-icinga0.upr.edu.cu' ],
  }
}
