# == Class: gitlabprodserver
#
# Full description of class gitlabprodserver here.
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
#  class { gitlabprodserver:
#    servers   => [ 'pool.ntp.org', 'ntp.local.company.com' ]
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
class gitlabprodserver{
  class { '::basesys':
  uprinfo_usage  => 'servidor gitlab',
  application    => 'production',
  puppet_enabled => false,
  #mta_enabled    => false,
  dmz            => true,
  repos_enabled  => true;
  }

  include gitlabserver

  # To install puppet-lint
  package { 'puppet-lint':
  ensure   => '1.1.0',
  provider => 'gem',
  }
}

