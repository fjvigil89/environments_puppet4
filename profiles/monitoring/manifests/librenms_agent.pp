# class monitoring::librenms_agent
#
#============================
#
# Configure librenms_agent
#

class monitoring::librenms_agent {
class { 'snmpd':
  package       => true,
  service       => true,
  allowed_hosts => [ 'localhost','10.2.1.250/32','10.2.9.0/24' ],
  community     => 'UPRadmin4all',
  syslocation   => 'UPR, Nodo Central',
  syscontact    => 'di@upr.edu.cu'
}
}
