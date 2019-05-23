node 'telefonos-pup.upr.edu.cu'{
 class{'::php_server':
   version      => '7.0',
   packages     => ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common','php7.0-gd','php7.0-gmp','php7.0-snmp'],
   manage_repos => true,
   }~>
   vcsrepo { '/var/www/telefonos':
     ensure     => latest,
	 provider   => 'git',
	 remote     => 'origin',
	 source     => {
	    'origin' => 'git@gitlab.upr.edu.cu:dcenter/telefonos.git',
	 },
	 revision   => 'master',
	 }
	 apache::vhost { 'telefonos':
	   serveraliases => 'www.telefonos-pup.upr.edu.cu',
	   port          => '80',
       docroot       => '/var/www/telefonos/web/',
       servername    => 'telefonos-pup.upr.edu.cu',
       aliases       => 'telefonos',
       directories   => [{
         'path' => '/var/www/telefonos/web/',
         'options'   => ['Indexes','FollowSymLinks','MultiViews'],
         'allow_override' => 'All',
         'allow'          => 'from All',
         'directoryindex' => 'app.php',
       },],
     }
	} 
