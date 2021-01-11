# == Class puppetprodserver::config
# This class is meant to be called from puppetprodserver
# it bakes the configuration file
# === Parameters
#
# [*options*]
#   A hash of extra options to set in the configuration
#
# === Example
#
#  class { puppetprodserver:
#    options => {
#      'key1' => 'value1',
#      'key2' => 'value2',
#    }
#  }
class puppetprodserver::config(
    $servers=$puppetprodserver::servers,
    $options=$puppetprodserver::options,
    ) {
  include puppetprodserver::params
  file { $puppetprodserver::params::conffile:
    ensure  => present,
    mode    => '0440',
    content => template('puppetprodserver/puppetprodserver.conf.erb')
  }
}

