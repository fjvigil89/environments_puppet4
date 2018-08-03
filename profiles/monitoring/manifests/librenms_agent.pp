# class monitoring::librenms_agent
#
#============================
#
# Configure librenms_agent
#

class monitoring::librenms_agent {
class { '::snmpd':
  #iface              => 'eth0',
  allow_address_ipv4 => '10.2.1.250',
  allow_netmask_ipv4 => '32',
  #users              => { 'monitor' => { 'pass' => 'my-password' } },
}
class { '::librenms::device':
  proto      => 'v2',
  community  => 'UPRadmin4all',
}
}
