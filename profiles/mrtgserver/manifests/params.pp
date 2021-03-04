# Class: mrtgserver::params
#
class mrtgserver::params {
  $owner = 'root'
  $group = 'root'
  $mode  = '0775'
  $comunidad = 'network4core@dminUPR'
  $ip = ['10.2.0.1','192.168.100.1','10.2.0.2']
  $names = ['L3','Cisco2911','sw-fibra']
  }
