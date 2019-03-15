# Class: metricbeatserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver(
  Array[Hash] $modules    = $metricbeatserver::params::modules,
  Hash $outputs           = $metricbeatserver::params::outputs,
  Boolean $manage_repo     = false,
)inherits ::metricbeatserver::params {


  class {'::metricbeatserver::install':;}
  class {'::metricbeatserver::service':;}

}
