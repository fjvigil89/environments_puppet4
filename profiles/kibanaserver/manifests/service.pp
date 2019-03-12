# Class: kibanaserver::service
# ===========================
#
#
class kibanaserver::service {

  vcsrepo { '/home/root/elk/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/kibana.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_kibana":
      command => '/usr/bin/sudo dpkg -i /home/root/elk/kibana-6.6.0-amd64.deb',
    }
  exec{"restart_kibana":
      command => '/usr/bin/sudo systemctl restart kibana',
    }~>
  exec{"enable_elasticsearch":
      command => '/usr/bin/sudo systemctl enable kibana',
    }

}
