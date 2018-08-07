# == Class: puppetdbprod
#
# Full description of class puppetdbprod here.
#

class puppetdbprod {
  class { '::basesys':
    uprinfo_usage  => 'servidor Puppet DB, Puppet-master, PuppetBoard',
    application    => 'puppet',
    puppet_enabled => false,
    repos_enabled  => false,
  }
  include puppetdb_server
  #To install puppet-lint
  package { 'puppet-lint':
    ensure   => '1.1.0',
    provider => 'gem',
  }
}
