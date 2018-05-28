# == Class puppetprodserver::install
# This class is meant to be called from puppetprodserver
# It install requires packages
class puppetprodserver::install {
  include puppetprodserver::params
  package { $puppetprodserver::params::pkgname:
    ensure => present,
  }
}
