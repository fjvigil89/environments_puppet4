#Clase telefonos::proyecto

class telefonos::proyecto {
 file { '/home/telefonos':
  ensure => directory,
  group  => 'root',
  owner  => 'root',
  mode   => '0775',
  }~>
  vcsrepo { '/home/telefonos':
    ensure   => latest,
    provider => 'git',
    remote   => 'origin',
    source   => {
      'origin' => 'git@gitlab.upr.edu.cu:dcenter/telefonos.git',
      },
    revision => 'master',
    }
  }
