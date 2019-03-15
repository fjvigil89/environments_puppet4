# Class: filebeatserver::service
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class filebeatserver::service(
  Optional[String] $type              = $::filebeatserver::type,
  Optional[String] $paths             = $::filebeatserver::paths,
  Optional[String] $log_type          = $::filebeatserver::log_type,
  Optional[String] $kibana_host       = $::filebeatserver::kibana_host,
  Optional[String] $kibana_username   = $::filebeatserver::kibana_username,
  Optional[String] $kibana_password   = $::filebeatserver::kibana_password,
  Optional[String] $logstash_host     = $::filebeatserver::logstash_host,

) {
  #class { 'filebeat':
  #  manage_repo         => false,
  #  outputs             => $::filebeatserver::outputs,
    
  #}

  file {'/etc/filebeat/filebeat.yml':
    notify =>  Service['filebeat'],
    content => template('filebeatserver/filebeat.erb'),
  }

  service{'filebeat':
    ensure => running,
    enable => true,
  }

}
