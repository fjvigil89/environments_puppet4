# == Class mailserver::params
# This class is meant to be called from mailserver
# It set variable according to platform
class mailserver::params {
  $pkgname = 'mailserver'
  $conffile = 'mailserver/etc/mailserver.conf'
  $service = $::osfamily ? {
    'Debian' => 'mailserver',
    'RedHat' => 'mailserver',
    default  => fail('unsupported platform')
  }


}
