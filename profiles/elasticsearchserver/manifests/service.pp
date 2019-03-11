# Class: elasticsearchserver::service
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class elasticsearchserver::service {

  vcsrepo { '/home/root/elk/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/elk.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_elasticsearch":
      command => '/usr/bin/sudo dpkg -i /home/root/elk/elasticsearch-6.6.0.deb',
    }~>
  exec{"restart_elasticsearch":
      command => '/usr/bin/sudo systemctl restart elasticsearch',
    }~>
  exec{"enable_elasticsearch":
      command => '/usr/bin/sudo systemctl enable elasticsearch',
    }

}

