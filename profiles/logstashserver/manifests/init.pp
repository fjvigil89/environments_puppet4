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
    '30-elasticsearch-output.conf',
  ],
){

  class {'::logstashserver::install':;}
  ~>class {'::logstashserver::service':;}

  each($filtros) |Integer $index, String $value|{
    logstashserver::files{$value :;}
  }


}
