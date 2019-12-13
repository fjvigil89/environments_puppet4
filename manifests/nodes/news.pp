node 'news.upr.edu.cu' {
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage  => 'servidor de noticias',
    application    => 'News server',
    repos_enabled  => false,
    mta_enabled    => false,

  }

  class{'::wh_php_apache':;}
  
  apache::vhost { 'sync.upr.edu.cu non-ssl':
    servername    => 'sync.upr.edu.cu',
    serveraliases => ['www.sync.upr.edu.cu'],
    port          => '80',
    docroot       => '/home/Sync-UPR/master/public/',
    directories   => [ {
      'path'           => '/home/Sync-UPR/master/public',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },],
      #redirect_status  => 'permanent',
      #redirect_dest    => 'https://sync.upr.edu.cu/',
  }

  exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod php7.0',
  }

  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
  }




}
