# Class: logstashserver::service
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver::service {


    service{'logstash':
      ensure => running,
      enable => true,
    }


}

