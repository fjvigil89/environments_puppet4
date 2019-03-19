# Class: logstashserver::install
# ===========================
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class logstashserver::install {


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
  each($::logstashserver::filtros) |Integer $index, String $value|{
    logstashserver::files{$value :;}
  }

}

