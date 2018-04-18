# == Class basesys::params
# This class is meant to be called from basesys
# It set variable according to platform
class basesys::params {
  $pkgname = 'basesys'
  $conffile = 'basesys/etc/basesys.conf'
  $service = $::osfamily ? {
    'Debian' => 'basesys',
    'RedHat' => 'basesys',
    default  => fail('unsupported platform')
  }
}
