# == Class basesys::config
# This class is meant to be called from basesys
# it bakes the configuration file
# === Parameters
#
# [*options*]
#   A hash of extra options to set in the configuration
#
# === Example
#
#  class { basesys:
#    options => {
#      'key1' => 'value1',
#      'key2' => 'value2',
#    }
#  }
class basesys::config(
    $servers=$basesys::servers,
    $options=$basesys::options,
    ) {
  include basesys::params
  file { $basesys::params::conffile:
    ensure  => present,
    mode    => '0440',
    content => template('basesys/basesys.conf.erb')
  }
}

