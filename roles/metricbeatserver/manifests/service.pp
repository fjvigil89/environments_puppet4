# Class: metricbeatserver::service
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver::service(
 Array[Hash] $modules   = $metricbeatserver::modules,
 Hash $outputs          = $metricbeatserver::outputs,
 Boolean $manage_repo   = $metricbeatserver::manage_repo,
 Integer $queue_size    = $metricbeatserver::queue_size,
) {

  class {'metricbeat':
    disable_configtest => true,
    queue_size         => $queue_size, 
    manage_repo        => $manage_repo,
    modules            => $modules,
    outputs            => $outputs, 
  }
}
