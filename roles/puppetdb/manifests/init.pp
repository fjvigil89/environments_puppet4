#Class: puppetdb_server
#================================
# Esta clase es par desplegar puppetdb
#
class puppetdbprodserver {
 class { '::basesys':
    uprinfo_usage  => 'servidor Puppet DB, Puppet-master, PuppetBoard',
    application    => 'puppet',
    puppet_enabled => false,
    repos_enabled  => false,
  }
 include puppetdb_server

 #To install puppet-lint
 package { 'puppet-lint':
  ensure                  => '1.1.0',
  provider                => 'gem',
  }

}

