# == Class: dhcpserver
#
# Full description of class dhcpserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'dhcpserver':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class dhcpserver {
	class { 'dhcp':
  service_ensure     => running,
  dnsdomain          => [$::basesys::params::dnssearchdomains],
  nameservers        => $::basesys::params::dnsservers,
  ntpservers         => $::basesys::params::ntp_server,
  interfaces         => ['eth0'],
  dnsupdatekey       => '/etc/bind/keys.d/rndc.key',
  dnskeyname         => 'rndc-key',
  #require           => Bind::Key['rndc-key'],
  omapi_port         => 7911,
  default_lease_time => 600,
  max_lease_time     => 7200
}

 dhcp::pool{ 'prueba del dhcp':
  network => '10.2.202.0',
  mask    => '255.255.255.0',
  range   => ['10.2.202.10 10.2.202.20', '10.2.202.21 10.2.202.50' ],
  gateway => '10.2.202.1',
}



}
