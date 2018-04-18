# == Class puppetdevserver::service
# This class is meant to be called from puppetdevserver
# It ensure the service is running
class puppetdevserver::service {
  include puppetdevserver::params
  service { $puppetdevserver::params::service:
    ensure => running,
    enable => true,
  }
}
