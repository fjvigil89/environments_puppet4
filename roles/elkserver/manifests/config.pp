# Class: elkserver::config
# ===========================
#
# Full description of class elkserver here.
class elkserver::config {


   file{'/etc/elasticsearch/jvm.options':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/elkserver/jvm.options',
  }~>
  file{'/usr/lib/systemd/system/elasticsearch.service':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/elkserver/elasticsearch.service',
  }~>
  file{'/etc/default/elasticsearch':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/elkserver/elasticsearch',
      notify => Exec['systemctl'];
  }~>
  file{'/etc/elasticsearch/elasticsearch.yml':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/elkserver/elasticsearch.yml',
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

