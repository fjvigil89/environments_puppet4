# == Class mailserver::install
# This class is meant to be called from mailserver
# It install requires packages
class mailserver::install {
  include mailserver::params
  package { $mailserver::params::pkgname:
    ensure => present,
  }
}
