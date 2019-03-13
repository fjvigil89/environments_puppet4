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
  class {'::logstashserver':;}

  class { 'filebeat':
    outputs => {
      'logstash'     => {
        'hosts' => [
          'localhost:5044',
          '10.2.4.26:5044'
        ],
        'loadbalance' => true,
      },
    },
  }
  filebeat::prospector { 'syslogs':
    paths    => [
      '/var/log/auth.log',
      '/var/log/syslog',
    ],
    doc_type => 'syslog-beat',
  }

}
