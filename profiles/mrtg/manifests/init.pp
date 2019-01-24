#Clase MRTG

class mrtg (
  $owner = $::mrtg::params::owner,
  $group = $::mrtg::params::group,
  $mode = $::mrtg::params::mode,
  $community = $::mrtg::params::community,
  Array[String] $ip = $::mrtg::params::ip,
  Array[String] $names = $::mrtg::params::name,
)inherits ::mrtg::params {
  include ::mrtg::apache
  include ::mrtg::device
  package { 'mrtg':
    name   => $operatingsystem ? {
      default => "mrtg",
    },
    ensure => installed,
  }

  file { "mrtg.cfg":
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    require => Package["mrtg"],
    ensure  => present,
    path    => $operatingsystem ? {
    default => "/etc/mrtg/mrtg.cfg"
    },
  }

  file { '/var/www/mrtg':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
}
