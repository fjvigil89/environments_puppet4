# Class: logstashserver::service
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver::service {


    vcsrepo { '/home/root/logstash/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/logstash.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_logstash":
      command => '/usr/bin/sudo dpkg -i /home/root/logstash/logstash-6.6.0.deb',
    }~>   
    service{'logstash':
      ensure => running,
      enable => true,
    }


}

