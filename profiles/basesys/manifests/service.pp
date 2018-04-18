# == Class basesys::service
# This class is meant to be called from basesys
# It ensure the service is running
class basesys::service {
  include basesys::params
  service { $basesys::params::service:
    ensure => running,
    enable => true,
  }
}
