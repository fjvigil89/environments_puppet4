# Class: elknodeserver
# ===========================
#
# Full description of class elknodeserver here.
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class elknodeserver {

include git
  #Copy SSH Key
  file { '/root/.ssh/id_rsa':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => 'puppet:///modules/elknodeserver/ssh/id_rsa',
  }~>
  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/elknodeserver/ssh/id_rsa.pub',
  }~>
  class {'::elasticsearchserver':;}~>
  file{'/etc/elasticsearch/elasticsearch.yml':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/elknodeserver/elasticsearch.yml',
      #before => Exec['instalar_elasticsearch'],
      notify => Service['elasticsearch'];
  }
  service{'elasticsearch':
    ensure => running,
    enable => true,
  }
}
