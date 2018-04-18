# == Class puppetdevserver::install
# This class is meant to be called from puppetdevserver
# It install requires packages
class puppetdevserver::install {
  include puppetdevserver::params
  package { $puppetdevserver::params::pkgname:
    ensure => present,
  }
}
