# == Class puppetdevserver::config
# This class is meant to be called from puppetdevserver
# it bakes the configuration file
# === Parameters
#
# [*options*]
#   A hash of extra options to set in the configuration
#
# === Example
#
#  class { puppetdevserver:
#    options => {
#      'key1' => 'value1',
#      'key2' => 'value2',
#    }
#  }
class puppetdevserver::config(){
    #$servers=$puppetdevserver::servers,
    #$options=$puppetdevserver::options,
    #) {
  #include puppetdevserver::params
  #file { $puppetdevserver::params::conffile:
  #  ensure  => present,
  #  mode    => '0440',
  #  content => template('puppetdevserver/puppetdevserver.conf.erb')
  #}
}

