# Class: filebeatserver::install
# ===========================
# Full description of class filebeat here.
# ---------
# Copyright 2019 Your name here, unless otherwise noted.
#
class filebeatserver::install{
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
    }
}
