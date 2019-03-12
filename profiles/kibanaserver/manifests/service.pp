# Class: kibanaserver::service
# ===========================
#
#
class kibanaserver::service {

  vcsrepo { '/home/root/kibana/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/kibana.git',
      },
      revision   => 'master',
    }~>
  exec{"instalar_kibana":
      command => '/usr/bin/sudo dpkg -i /home/root/kibana/kibana-6.6.0-amd64.deb',
    }
  exec{"restart_kibana":
      command => '/usr/bin/sudo systemctl restart kibana',
    }~>
  exec{"enable_kibana":
      command => '/usr/bin/sudo systemctl enable kibana',
    }

  file{'/etc/kibana/kibana.yml':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/kibanaserver/kibana.yml',
      before => Exec['instalar_kibana'],
      notify => Exec['restart_kibana'];
  }

}
