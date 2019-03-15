# Class: filebeatserver::service
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class filebeatserver::service(
  Hash $outputs        = $::filebeatserver::params::outputs,
) {
  class { 'filebeat':
    manage_repo         => false,
    outputs             => $outputs,
    
  }

}
