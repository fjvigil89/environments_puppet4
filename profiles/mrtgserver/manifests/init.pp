#Clase mrtgserver

class mrtgserver (
  
  $owner = $::mrtgserver::params::owner,
  $group = $::mrtgserver::params::group,
  $mode = $::mrtgserver::params::mode,
  $comunidad = $::mrtgserver::params::comunidad,
  
  Array[String] $ip = $::mrtgserver::params::ip,
  Array[String] $names = $::mrtgserver::params::names,

)inherits ::mrtgserver::params {
  
  class {'::mrtgserver::apache':;}
  class {'::mrtgserver::mrtg':;}
  #  class {'::mrtgserver::device':;}
}

