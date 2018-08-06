# Class: dhcp_server
# ===========================
#
# Configuration of dhcp_server

class dhcp_server {
class { 'dhcp':
  service_ensure => running,
  nameservers  => ['10.2.1.8'],
  ntpservers   => ['ntp.upr.edu.cu'],
  interfaces   => ['eth0'],
  dnsupdatekey => '/etc/bind/keys.d/rndc.key',
  dnskeyname   => 'rndc-key',
  require      => Bind::Key['rndc-key'],
}
dhcp::pool { 'nodo.upr.edu.cu':
  network => '10.2.9.0',
  mask    => '255.255.255.0',
  range   => ['10.2.9.100 10.0.1.200' ],
  gateway => '10.2.9.1',
}

}
