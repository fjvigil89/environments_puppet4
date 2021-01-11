node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}~>
  class {'::filebeatserver':
    log_type => "syslog",
  }
  class {'::metricbeatserver':
   modules  => ['system','elasticsearch','kibana', 'logstash','nginx']
  }



}
node /^elk-cluster\d+$/ {

 class { '::elknodeserver':;}
 class {'::filebeatserver':
    log_type => "syslog",
  }

 class {'::metricbeatserver':
    modules  => ['system','elasticsearch']
  }


}

