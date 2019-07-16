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

  #class {'metricbeat':
  #  major_version      => '6',
  #  disable_configtest => true,
  #  queue_size         => $queue_size, 
  #  manage_repo        => $manage_repo,
  #  modules            => $modules,
  #  outputs            => $outputs, 
  #}

  file {'/etc/metricbeat/metricbeat.yml':
    notify =>  Service['filebeat'],
    content => template('metricbeatserver/metricbeat.erb'),
  }~>
  #exec{"module_System":
  #    command => '/usr/bin/sudo metricbeat modules enable system',
  # }~>
  each($::metricbeatserver::modules) |Integer $index, String $value|{
    metricbeatserver::module{$::metricbeatserver::modules[$index]:
       module => $value,
     }
  }~>
  service{'metricbeat':
    ensure => running,    
    enable => true,
  }

}
