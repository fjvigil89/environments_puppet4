node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}~>
  class {'::filebeatserver':
    type     => "log_elk",
    log_type => "syslog",
  }
  class {'metricbeatserver':;}


}
