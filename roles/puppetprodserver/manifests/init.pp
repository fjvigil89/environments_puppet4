# == Class: puppetprodserver
#
# Full description of class puppetprodserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { puppetprodserver:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class puppetprodserver () {
  #anchor { "${module_name}::begin": } ->
  #class {"${module_name}::install": } ->
  #class {"${module_name}::config": } ~>
  #class {"${module_name}::service": } ~>
  #anchor { "${module_name}::end": }
 class { '::basesys':
    uprinfo_usage  => 'Puppet Server UPR',
    application      => 'puppetserver',
    application_tier => 'prd',
    puppet_enabled   => false,
  }

  class { '::puppet4server':
    puppetdb_server => 'pupppetdb.upr.edu.cu';
  }
}
