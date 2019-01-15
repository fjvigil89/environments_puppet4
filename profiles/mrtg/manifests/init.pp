#Clase MRTG

class mrtg {
  include apache

  package { mrtg:
    name   => $operatingsystem ? {
      default => "mrtg",
    },
    ensure => present,
  }

  file { "/etc/apache2/conf.d/mrtg.conf":
    owner  => root,
    group  => root,
    mode   => '644',
    ensure => present,
    #    require => Package["apache2"],
    # source  => "puppet://$server/modules/mrtg/mrtg.httpd",
  }

  file { "mrtg.cfg":
    owner   => root,
    group   => root,
    mode    => '644',
    require => Package["mrtg"],
    ensure  => present,
    path    => $operatingsystem ? {
    default => "/etc/mrtg/mrtg.cfg"
    },
  }

  file { '/var/www/mrtg':
    ensure => directory,
    owner  => www-data,
    group  => www-data,
    mode   => '775',
  }

  file {'/var/www/whois':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '775',
    require => Package["whois"],
  }
}
