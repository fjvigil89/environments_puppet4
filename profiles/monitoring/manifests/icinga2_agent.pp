# class monitoring::icinga2_agent
#
#============================
#
# Configure icinga2_agent
#

class monitoring::icinga2_agent {
  include ::monitoring::params
  file { '/etc/icinga2/conf.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => true,
    recurse => true,
    require => Package['icinga2'],
  }

  class { '::icinga2':
    manage_repo => $monitoring::params::manage_repo,
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
  each($::monitoring::params::icinga_servers) |Integer $index, String $value| {
    icinga2::object::endpoint { $value:
      host => $::monitoring::params::icinga_ipservers[$index],
    }
  }
  #Configure Zones
  icinga2::object::zone { $::fqdn:
    endpoints => [ $fqdn ],
    parent    => 'master',
  }
  icinga2::object::zone { 'master':
    endpoints => $::monitoring::params::icinga_servers,
  }
}
