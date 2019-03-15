node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}->
  class {'::filebeatserver':;}
  filebeatserver::prospector{'logs':
    paths    => [
    '/var/log/*',
    ],
    doc_type => 'syslogs',
  }
    

  class {'metricbeatserver':;}


}
