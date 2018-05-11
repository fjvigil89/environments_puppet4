# == Class mailserver::config
# This class is meant to be called from mailserver
# it bakes the configuration file
# === Parameters
#
# [*options*]
#   A hash of extra options to set in the configuration
#
# === Example
#
#  class { mailserver:
#    options => {
#      'key1' => 'value1',
#      'key2' => 'value2',
#    }
#  }
class mailserver::config(
    $servers=$mailserver::servers,
    $options=$mailserver::options,
    ) {
  include mailserver::params
  file { $mailserver::params::conffile:
    ensure  => present,
    mode    => '0440',
    content => template('mailserver/mailserver.conf.erb')
  }
}

