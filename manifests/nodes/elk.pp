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

  vcsrepo { '/home/root/filebeat/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/filebeat.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_filebeat":
      command => '/usr/bin/sudo dpkg -i /home/root/filebeat/filebeat-6.6.2-amd64.deb',
    }~>
  class { 'filebeat':
    manage_repo => false,
    outputs     => {
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
