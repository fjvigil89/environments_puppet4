# Class: metricbeatserver::service
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver::service(
  #Array[Hash] $modules   = $metricbeatserver::modules,
 Hash $outputs          = $metricbeatserver::outputs,
 Boolean $manage_repo   = $metricbeatserver::manage_repo,
 Integer $queue_size    = $metricbeatserver::queue_size,
) {

  file {'/etc/metricbeat/metricbeat.yml':
    notify =>  Service['filebeat'],
    content => template('metricbeatserver/metricbeat.erb'),
  }
  each($::metricbeatserver::modules) |Integer $index, String $value|{
    metricbeatserver::module{$::metricbeatserver::modules[$index]:
       module => $value,
     }
  }
  service{'metricbeat':
    ensure => running,    
    enable => true,
  }

}
