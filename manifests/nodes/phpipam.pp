node 'phpipam.upr.edu.cu'{
  class{'::php_server':
      version      => '7.2',
      packages     => ['php7.2-mbstring','r10k','php7.2','php7.2-cli','php7.2-curl','php7.2-intl','php7.2-ldap','php7.2-mysql','php7.2-sybase','libapache2-mod-php7.2','php7.2-mcrypt','phpmyadmin','freetds-bin','freetds-common', 'php7.2-gd','php7.2-gmp'],
      manage_repos => true, 

    }
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
      redirect_status  => 'permanent',
      redirect_dest    => 'https://phpipam.upr.edu.cu/',
  }
}

