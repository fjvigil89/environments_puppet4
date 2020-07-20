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
  allowed_hosts => [ 'localhost','10.2.0.0/21' ],
  community     => 'UPRadmin4all',
  syslocation   => 'UPR, Nodo Central',
  syscontact    => 'upredes@upr.edu.cu'
}
}
