#Clase MRTG

class mrtgserver::mrtg(){
  package { 'mrtg':
    #   name   => $operatingsystem ? {
    #default => 'mrtg',
    #},
    ensure => installed,
  }
  each ($::mrtgserver::ip) |Integer $index, String $value|{
    exec {'cfg':
      command => "cfgmaker $community@$value > /etc/mrtg/$names[$index].cfg",
    }
  }
  #file { "mrtg.cfg":
  #  owner   => $owner,
  #  group   => $group,
  #  mode    => $mode,
  #  require => Package["mrtg"],
  #  ensure  => present,
  #  path    => $operatingsystem ? {
  #    default => "/etc/mrtg/mrtg.cfg"
  #  },
  #}
  file { '/var/www/mrtg':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
}
