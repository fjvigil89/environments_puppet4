node 'telefonos-pup.upr.edu.cu' {  

class{'::telefonos':
  
  vcsrepo { '/var/www/whois':
    ensure   => latest,
    provider => 'git',
    remote   => 'origin',
    source   => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/whois.git',
	},
    revision => 'master',
    }
  
  apache::vhost { 'telefonos':
    port       => '80',
    docroot    => '/home/telefonos/web',
    servername => 'telefonos-pup.upr.edu.cu',
    aliases    => 'telefonos',
    }
  }
