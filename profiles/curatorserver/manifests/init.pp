# Class: curatorserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class curatorserver(
  Boolean $manage_repository      = $::curatorserver::params::manage_repository,
  Array[String] $nombre           = $::curatorserver::params::nombre,
  Array[String] $descripcion      = $::curatorserver::params::descripcion,
  Array[String] $index            = $::curatorserver::params::index,
  String $repository_version      = $::curatorserver::params::repository_version,

)inherits curatorserver::params {

  class {'::curator':
    manage_repository => $manage_repository,
  }
  class {'::curatorserver::accion':;}
  class {'::curatorserver::job':;}

}
