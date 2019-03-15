# Class: metricbeatserver::service
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver::service(
 Array[Hash] $modules   = $metricbeatserver::modules,
 Hash $outputs          = $metricbeatserver::outputs,
 Boolean $manage_repo   = $metricbeatserver::manage_repo,
) {

  class {'metricbeat':
    manage_repo => $manage_repo,
    modules =>$modules,
    outputs =>$outputs, 
  }
}
