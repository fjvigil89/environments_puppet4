# Class: metricbeatserver::params
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver::params{
  $modules      = ['system']
  $outputs      = {}
  $queue_size   = 2000

}

