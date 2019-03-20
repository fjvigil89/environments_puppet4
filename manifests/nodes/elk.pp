node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}~>
  class {'::filebeatserver':
    log_type => "syslog",
  }
  class {'metricbeatserver':;}


}
