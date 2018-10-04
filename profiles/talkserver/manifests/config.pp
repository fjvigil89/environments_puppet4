#Clase prosody::config

class talkserver::config {
  file { '/etc/prosody/conf.avail':
    ensure => directory,
  }

  file { '/etc/prosody/conf.d':
    ensure => directory,
  }

  file { '/etc/prosody/prosody.cfg.lua':
    content => template('prosody/prosody.cfg.erb'),
    require => Class['::prosody::package'],
    notify  => Class['::prosody::service'],
  }
}
