# == Class puppetdevserver::params
# This class is meant to be called from puppetdevserver
# It set variable according to platform
class puppetdevserver::params {
  $pkgname = 'puppetdevserver'
  $conffile = 'puppetdevserver/etc/puppetdevserver.conf'
  $service = $::osfamily ? {
    'Debian' => 'puppetdevserver',
    'RedHat' => 'puppetdevserver',
    default  => fail('${::operatingsystem} unsupported platform')
  }
}
