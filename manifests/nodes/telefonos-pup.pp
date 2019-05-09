node 'telefonos-pup.upr.edu.cu'{

include telefonos

file { '/home/telefonos':
  ensure => directory,
  group  => 'root',
  owner  => 'root',
  mode   => '0775',
  }~>
  vcsrepo { '/home/telefonos':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/telefonos.git',
      },
      revision   => 'master',
    }
apache::vhost { 'telefonos':
	port       => '80',
	docroot    => '/home/telefonos/',
	servername => 'telefonos-pup.upr.edu.cu',
	aliases    => 'telefonos',
	}
}
