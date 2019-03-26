node 'client-puppet.upr.edu.cu'{
  #class {'::talkserver':;}
  class { '::basesys':
    uprinfo_usage   => 'servidor test',
    application     => 'puppet',
    # repos_enabled => false,
    dmz             => true,

  }
  #class { 'squidserver':;}
  $myconfig =  @("MYCONFIG"/L)
  input {
    beats {
      port => 5043
    }
  }
  output {
    elasticsearch {
      hosts => "10.2.1.205:9200"
      manage_template => false
      index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
      document_type => "%{[@metadata][type]}"
    }
    stdout { codec => rubydebug }
  }
  | MYCONFIG

  include ::java
  class { 'elasticsearch':
    #elasticsearch_user => 'elasticsearch',
    manage_repo        => false,
    restart_on_change  => true,
    autoupgrade        => true,
  }
  elasticsearch::instance { 'es-01':
     config => {
      'network.host' => '10.2.1.205',
    },
  }
  class { 'logstash':
    manage_repo       => false,
    restart_on_change => true,
    auto_upgrade      => true,
    settings          => {
      'http.host' => '10.2.1.205',
    }
  }

  logstash::configfile { '02-beats-input.conf':
    content => $myconfig,
  }
  logstash::plugin { 'logstash-input-beats': }

  class { 'kibana' :
    manage_repo => false,
    config      => {
      'server.host'       =>  '10.2.1.205',
      'elasticsearch.url' => 'http://10.2.1.205:9200',
      'server.port'       => '5601',
    }
  }

  class { 'filebeat':
    manage_repo => false,
    outputs     => {
      'logstash' => {
        'hosts' => [
          '10.2.1.205:5043',
        ],
        'index' => 'filebeat',
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
node 'mrtg-puppet.upr.edu.cu' {
  include mrtgserver
  package { 'lsb-release':
    ensure => installed,
    }~>
    class { '::basesys':
      uprinfo_usage => 'Servidor mrtg',
      application   => 'mrtg',
      proxmox_enabled => false,
    }
}
  #  class { 'prosody':
  #  user              => 'prosody',
  #  group             => 'prosody',
  #  community_modules => ['mod_auth_ldap'],
  #  authentication    => 'ldap',
  #  custom_options    => {
  #    'ldap_base'     => "'OU=Servicios','DC=upr','DC=edu','DC=cu'",
  #    'ldap_server'   => "'10.2.24.35:636'",
  #    'ldap_rootdn'   => "'CN=talk','OU=_Servicios','DC=upr','DC=edu','DC=cu'",
  #    'ldap_password' => "'40a*talk.2k12'",
  #    'ldap_scope'    => 'subtree',
  #    'ldap_tls'      => 'true',
  #  },
  #}
  #prosody::virtualhost {
  #  "chat.upr.edu.cu" :
  #    ensure   => present,
  #    ssl_key  => '/etc/prosody/certs/localhost.key',
  #    ssl_cert => '/etc/prosody/certs/localhost.crt',
  #}
  #prosody::user { 'admin':
  #  host => "chat.upr.edu.cu",
  #  pass => '12345',
  #}
  #}
