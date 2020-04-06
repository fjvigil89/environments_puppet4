node 'phpipam.upr.edu.cu'{
  class{'::php_server':
      version      => '7.0',
      packages     => ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common', 'php7.0-gd','php7.0-gmp','php7.0-snmp'],
      manage_repos => true, 

    }~>
    vcsrepo { '/var/www/phpipam/':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/phpipam.git',
      },
      revision   => 'master',
      submodules => true,
    }~>
  apache::vhost { 'phpipam.upr.edu.cu non-ssl':
    servername    => 'phpipam.upr.edu.cu',
    serveraliases => ['www.phpipam.upr.edu.cu'], 
    port          => '80',
    docroot	      => '/var/www/phpipam/',
    directories   => [ {
      'path'           => '/var/www/phpipam',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },],
      #redirect_status  => 'permanent',
      #redirect_dest    => 'https://phpipam.upr.edu.cu/',
  }~>
  exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod php7.0',
  }~>
  exec{"a2enmod_rewrite":
    command => '/usr/bin/sudo a2enmod rewrite',
  }~>
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
  }

}

