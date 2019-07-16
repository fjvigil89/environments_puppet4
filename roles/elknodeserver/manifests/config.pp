# Class: elknodeserver:config
# ===========================
#
# Full description of class elknodeserver here.
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class elknodeserver::config{

  file{'/etc/elasticsearch/jvm.options':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      # content => template('elknodeserver/elasticsearch.yml.erb'),
      source => 'puppet:///modules/elknodeserver/jvm.options',
      #before => Exec['instalar_elasticsearch'],
      #notify => Service['elasticsearch'];
  }~>
  file{'/usr/lib/systemd/system/elasticsearch.service':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      # content => template('elknodeserver/elasticsearch.yml.erb'),
      source => 'puppet:///modules/elknodeserver/elasticsearch.service',
      #before => Exec['instalar_elasticsearch'],
      #notify => Service['elasticsearch'];
  }~>
  file{'/etc/default/elasticsearch':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      # content => template('elknodeserver/elasticsearch.yml.erb'),
      source => 'puppet:///modules/elknodeserver/elasticsearch',
      #before => Exec['instalar_elasticsearch'],
      notify => Exec['systemctl'];
  }~>
  file{'/etc/elasticsearch/elasticsearch.yml':
    # path   => '/etc/elasticsearch/elasticsearch.yml',
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      # content => template('elknodeserver/elasticsearch.yml.erb'),
      source => 'puppet:///modules/elknodeserver/elasticsearch.yml',
      #before => Exec['instalar_elasticsearch'],
      notify => Service['elasticsearch'];
  }
  service{'elasticsearch':
    ensure => running,
    enable => true,
  }

  exec{"systemctl":
    command => '/usr/bin/sudo systemctl daemon-reload',
  }
}

