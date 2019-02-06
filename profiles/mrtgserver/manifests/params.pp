# Class: mrtgserver::params
#
class mrtgserver::params {
  $owner = 'root'
  $group = 'root'
  $mode  = '0775'
  $community = 'network4core@dminUPR'
  $ip = ['10.2.1.1','10.2.8.6']
  $names = ['L3','2960']
  }
