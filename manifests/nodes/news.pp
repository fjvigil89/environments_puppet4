node 'news.upr.edu.cu' {

  class{'::wh_php_apache':;}
  
  apache::vhost { 'news.upr.edu.cu non-ssl':
    servername    => 'news.upr.edu.cu',
    serveraliases => ['www.news.upr.edu.cu'],
    port          => '80',
    docroot       => '/home/News-UPR/master/',
    directories   => [ {
      'path'           => '/home/News-UPR/master',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },],
      #redirect_status  => 'permanent',
      #redirect_dest    => 'https://sync.upr.edu.cu/',
  }->
  phpmyadmin::vhost { 'phpmyadmin.news.upr.edu.cu':
    vhost_enabled => true,
    priority      => '20',
    docroot       => $phpmyadmin::params::doc_path,
    ssl           => false,
    # ssl_cert      => 'puppet:///modules/phpmyadmin/sslkey/internal.domain.net.crt',
    #ssl_key       => 'puppet:///modules/phpmyadmin/sslkey/internal.domain.net.private.key',
  }->
  exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod php7.0 | /usr/bin/sudo service apache2 restart',
  }->
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
  }->
  class {'r10kserver':
    r10k_basedir => "/home/News-UPR",
    cachedir     => "/var/cache/r10k",
    configfile   => "/etc/r10k/r10k.yaml",
    remote       => "git@gitlab.upr.edu.cu:ysantalla/app-noticias.git",
    sources      => {
      'News-UPR' => {
        'remote'           => 'git@gitlab.upr.edu.cu:ysantalla/app-noticias.git',
        'basedir'          => '/home/News-UPR',
        'prefix'           => false,
        'invalid_branches' => 'correct',
    },
  }
  } 


}
