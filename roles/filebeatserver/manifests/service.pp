# Class: filebeatserver::service
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class filebeatserver::service(
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
