# == Class basesys::install
# This class is meant to be called from basesys
# It install requires packages
class basesys::install {
  include basesys::params
  package { $basesys::params::pkgname:
    ensure => present,
  }
}
