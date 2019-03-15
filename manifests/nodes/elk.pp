node 'elk.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor ELK',
    application     => 'ELK',    
    #repos_enabled   => true,
    #mta_enabled     => false,
  }


  $packages=['apt-transport-https', 'software-properties-common', 'wget','pwgen','ufw']
  ensure_packages($packages, {
    ensure => present,
    })

  include git
  class {'::elasticsearchserver':;}->
  class {'::kibanaserver':;}->
  class {'::logstashserver':;}->
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
    



}
