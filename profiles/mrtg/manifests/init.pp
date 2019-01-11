#Clase MRTG

class mrtg {
  include apache

  package { mrtg:
    ensure => present,
    name   => $operatingsystem ? {
      default => "mrtg",
    },
  }

  file { "/etc/apache2/conf.d/mrtg.conf":
    ensure  => present,
    owner   =>root,
    group   => root,
    mode    => 644,
    require => Package["apache2"],
    # source  => "puppet://$server/modules/mrtg/mrtg.httpd",
  }

  file { "mrtg.cfg":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    require => Package["mrtg"],
    path    =>  $operatingsystem ? {
      default => "/etc/mrtg/mrtg.cfg",
    },
  }
}
