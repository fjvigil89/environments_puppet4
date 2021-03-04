# Class: logstashserver::service
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver::service {

    service{'logstash':
      ensure => running,
      enable => true,
    }
  
  file{'/etc/logstash/conf.d/02-beats-input.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/02-beats-input.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }

  file{'/etc/logstash/conf.d/10-syslog-filter.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/10-syslog-filter.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }
  file{'/etc/logstash/conf.d/11-proxy-filter.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/11-proxy-filter.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }

  file{'/etc/logstash/conf.d/12-apache-filter.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/logstashserver/12-apache-filter.conf',
    #before => Exec['instalar_logstash'],
    notify => Service['logstash'];
  }


}

