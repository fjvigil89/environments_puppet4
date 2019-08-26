# Class: curatorserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class curatorserver(
  Boolean $manage_repository     = $::curatorserver::params::manage_repository,
  Array[String] name             = $::curatorserver::params::name,
  Array[String] descripcion      = $::curatorserver::params::descripcion,
  Array[String] index            = $::curatorserver::params::index,

)inherits curatorserver::params {

  class {'::curator':
    manage_repository => $manage_repository,
  }
  class {'::curatorserver::action':;}
  class {'::curatorserver::job':;}

}
