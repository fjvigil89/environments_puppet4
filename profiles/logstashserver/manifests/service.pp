# Class: logstashserver::service
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver::service {


  each($::logstashserver::filtros) |Integer $index, String $value|{
    logstashserver::files{$value :;}
  }

    service{'logstash':
      ensure => running,
      enable => true,
    }


}

