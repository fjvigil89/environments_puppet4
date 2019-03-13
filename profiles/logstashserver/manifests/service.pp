# Class: logstashserver::service
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver::service {


    vcsrepo { '/home/root/logstash/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/logstash.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_logstash":
      command => '/usr/bin/sudo dpkg -i /home/root/logstash/logstash-6.6.0.deb',
    }->
    #exec{"restart_logstash":
    #  command => '/usr/bin/sudo systemctl restart logstash | systemctl enable logstash',
    #  refreshonly => true;
    #}
    #exec{"enable_logstash":
    #  command => '/usr/bin/sudo systemctl enable logstash',
    #}->

  file{'/etc/logstash/conf.d/02-beats-input.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/02-beats-input.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }~>

  file{'/etc/logstash/conf.d/10-syslog-filter.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/10-syslog-filter.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }~>
  
  file{'/etc/logstash/conf.d/30-elasticsearch-output.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/30-elasticsearch-output.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }
  service{'logstash':
    ensure => running,
    enable => true,
  }





}

