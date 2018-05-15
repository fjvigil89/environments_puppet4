#
#  Class graphite_server
#================================
#

class graphite_server {
class { '::basesys':
    uprinfo_usage  => 'graphite_server',
    application    => 'graphite',
    puppet_enabled => false,
    mta_enabled    => false,
  }
}

