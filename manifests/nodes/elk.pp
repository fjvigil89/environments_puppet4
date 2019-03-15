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
    

  class {'metricbeatserver':
  modules => [
    {
      'module'     => 'nginx',
      'metricsets' => ['status'],
      'hosts'      => ['http://localhost'],
    },
  ],
  outputs => {
    'elasticsearch' => {
      'hosts' => ['10.2.4.26:9200'],
    },
  },
}


}
