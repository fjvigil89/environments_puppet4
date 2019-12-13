node 'news.upr.edu.cu' {

  class{'::wh_php_apache':;}
  
  apache::vhost { 'news.upr.edu.cu non-ssl':
    servername    => 'news.upr.edu.cu',
    serveraliases => ['www.news.upr.edu.cu'],
    port          => '80',
    docroot       => '/home/News-UPR/master/public/',
    directories   => [ {
      'path'           => '/home/News-UPR/master/public',
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
