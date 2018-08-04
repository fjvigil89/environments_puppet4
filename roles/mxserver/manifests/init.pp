# Class: mxserver
# ===========================
# Configure MX Server
#
class mxserver {
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor mx',
    application    => 'MX Postfix',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => true,
  }
  include mx_server
}
