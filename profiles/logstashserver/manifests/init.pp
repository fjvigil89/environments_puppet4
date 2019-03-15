# Class: logstashserver
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver
(
  Array[String] $filtros = [
    '02-beats-input.conf',
    '10-syslog-filter.conf',
    '11-proxy-filter.conf',
    '30-elasticsearch-output.conf',
  ],
){

  class {'::logstashserver::install':;}

  each($filtros) |Integer $index, String $value|{  
    logstashserver::files{$value :;}
  }
  class {'::logstashserver::service':;}


}
