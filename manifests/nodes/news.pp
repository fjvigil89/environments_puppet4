node 'news.upr.edu.cu' {

  class { '::basesys':
    uprinfo_usage  => 'servidor News',
    application    => 'puppet',
    #puppet_enabled => false,
    mta_enabled    => false,
  }

  class{'::wh_php_apache':;}
  
  apache::vhost { 'news.upr.edu.cu non-ssl':
    servername      => 'news.upr.edu.cu',
    serveraliases   => ['www.news.upr.edu.cu'],
    port            => '80',
    docroot         => '/home/News-UPR/master/',
    custom_fragment => 'Alias /phpmyadmin /usr/share/phpmyadmin',
    directories     => [ {
      'path'           => '/home/News-UPR/master',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },
      {
      'path'           => '/usr/share/phpmyadmin',
      'options'        => ['FollowSymLinks'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },
    ],
      #redirect_status  => 'permanent',
      #redirect_dest    => 'https://sync.upr.edu.cu/',
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


#  class { '::mysql::server':
#    root_password           => 'news',
#    remove_default_accounts => false,
#    restart                 => true,
#    override_options        => $override_options
#  }


}
