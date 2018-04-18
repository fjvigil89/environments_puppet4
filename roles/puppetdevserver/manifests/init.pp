# == Class: puppetdevserver
#
# Full description of class puppetdevserver here.
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
#  class { puppetdevserver:
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
class puppetdevserver{
  anchor { "${module_name}::begin": } ->
  class {"${module_name}::install": } ->
  class {"${module_name}::config": } ~>
  class {"${module_name}::service": } ~>
  anchor { "${module_name}::end": }
  
 class { '::basesys':
    uprinfo_usage  => 'Puppet dev server',
    application      => 'puppetserver',
    application_tier => 'dev',
    puppet_enabled   => false;
  }

  class { '::puppetdb_server':;}

  class { '::puppetserver':
    #puppetdb_server => $::fqdn;
    puppetdb_server => 'puppetdb.upr.edu.cu';
  }
}
