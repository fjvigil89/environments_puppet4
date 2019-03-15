node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}->
  class {'::filebeatserver':
   outputs => {
    'logstash'     => {
     'hosts' => [
       'localhost:5044',
       
     ]     
    },
  }
  }->
  filebeatserver::prospector{'logs':
    paths    => [
    '/var/log/*',
    ],
    doc_type => 'syslogs',
  }
    

  class {'metricbeatserver':;}


}
