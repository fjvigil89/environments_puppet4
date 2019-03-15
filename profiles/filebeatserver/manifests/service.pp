# Class: filebeatserver::service
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class filebeatserver::service(
  Hash $output         = $::filebeatserver::params::output,
) {
  class { 'filebeat':
    manage_repo         => false,
    outputs             => $output,
    },
  }

}
