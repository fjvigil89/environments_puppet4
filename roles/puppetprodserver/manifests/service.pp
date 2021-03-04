# == Class puppetprodserver::service
# This class is meant to be called from puppetprodserver
# It ensure the service is running
class puppetprodserver::service {
  include puppetprodserver::params
  service { $puppetprodserver::params::service:
    ensure => running,
    enable => true,
  }
}
