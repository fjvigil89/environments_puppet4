# Class: metricbeatserver::install
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class metricbeatserver::install {

  vcsrepo { '/home/root/metricbeat/':
    ensure     => latest,
    provider   => 'git',
    remote     => 'origin',
    source     => {
      'origin' => 'git@gitlab.upr.edu.cu:dcenter/kibana.git',
    },
    revision   => 'master',
    }~>
  exec{"instalar_metricbeat":
    command => '/usr/bin/sudo dpkg -i /home/root/metricbeat/metricbeat-6.6.0-amd64.deb',
  }
}

