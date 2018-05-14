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

  case $mailserver::application_type{
    'mx':{
      $mailserver::dir_source = 'puppet:///postfix/Ubuntu/mx',
    },
    'email':{
      $mailserver::dir_source = 'puppet:///postfix/Ubuntu/email',
      }  
}
