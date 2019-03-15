# Class: filebeatserver::params
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class filebeatserver::params{
  $type              = 'log'
  $paths             = "/var/log/*.log"
  $log_type          = undef
  $kibana_host       = "elk.upr.edu.cu:80"
  $kibana_username   = "kibanaadmin"
  $kibana_password   = "$*uprP@ssword*$"
  $logstash_host     = "10.2.4.26:5044" 
}
