#Clase mrtgserver

class mrtgserver (
  $owner = $::mrtgserver::params::owner,
  $group = $::mrtgserver::params::group,
  $mode = $::mrtgserver::params::mode,
  $community = $::mrtgserver::params::community,
  Array[String] $ip = $::mrtgserver::params::ip,
  Array[String] $names = $::mrtgserver::params::name,
)inherits ::mrtgserver::params {
  class {'::mrtgserver::apache':;}
  class {'::mrtgserver::device':;}
  class {'::mrtgserver::mrtg':;}
}

