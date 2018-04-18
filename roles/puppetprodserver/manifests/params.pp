# == Class puppetprodserver::params
# This class is meant to be called from puppetprodserver
# It set variable according to platform
class puppetprodserver::params {
  $pkgname = 'puppetprodserver'
  $conffile = 'puppetprodserver/etc/puppetprodserver.conf'
  $service = $::osfamily ? {
    'Debian' => 'puppetprodserver',
    'RedHat' => 'puppetprodserver',
    default  => fail('unsupported platform')
  }
}
