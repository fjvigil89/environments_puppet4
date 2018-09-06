# Class: repoFacult_server
# ===========================
#
# Full description of class repoFacult_server here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'repoFacult_server':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class repoFacult_server {
  class { '::basesys':
    ¦ uprinfo_usage  => 'servidor Repos Facultad',
    ¦ application    => 'Repos Server UPR',
    ¦ #puppet_enabled => false,
    ¦ #repos_enabled  => true,
    ¦ mta_enabled    => false,
  }

  file { "/repositorio":
    ¦ ensure => directory,
    ¦ owner  => 'root',
    ¦ mode   => '0777',
    }
  mount {'/repositorio':
    ¦device  => '10.2.25.1:/export/repos_facultades',
    ¦fstype  => 'nfs4',
    ¦ensure  => mounted,
    ¦options => 'default',
    ¦atboot  => true,
  }
   
}
