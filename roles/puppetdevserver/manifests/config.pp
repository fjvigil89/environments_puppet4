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
class puppetdevserver::config{
}

