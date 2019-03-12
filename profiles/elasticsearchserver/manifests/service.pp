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
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/elasticsearch.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_elasticsearch":
      command => '/usr/bin/sudo dpkg -i /home/root/elk/elasticsearch-6.6.0.deb',
    }
  exec{"restart_elasticsearch":
      command => '/usr/bin/sudo systemctl restart elasticsearch',
    }~>
  exec{"enable_elasticsearch":
      command => '/usr/bin/sudo systemctl enable elasticsearch',
    }

    file{'/etc/elasticsearch/elasticsearch.yml':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/elasticsearchserver/elasticsearch.yml',
      before => Exec['instalar_elasticsearch'],
      notify => Exec['restart_elasticsearch'];
  }

}

