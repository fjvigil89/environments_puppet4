# == Class: dhcpprodserver
#
# Full description of class dhcpprodserver here.
#
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class dhcpprodserver(){
  package { 'lsb-release':
     ensure =>  installed,
  }~>
  class { '::basesys':
  uprinfo_usage  => 'servidor dhcp',
  application    => 'production',
  #puppet_enabled => false,
  mta_enabled    => false,  
  }

}
