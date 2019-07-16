# Class: metricbeatserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver(
  Array[String] $modules   = $metricbeatserver::params::modules,
  Hash $outputs            = $metricbeatserver::params::outputs,
  Integer $queue_size      = $metricbeatserver::params::queue_size,
  Boolean $manage_repo     = false,
)inherits ::metricbeatserver::params {


  class {'::metricbeatserver::install':;}
  ~>class {'::metricbeatserver::service':;}

}
