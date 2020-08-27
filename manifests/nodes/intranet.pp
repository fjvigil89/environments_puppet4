node 'intranet.upr.edu.cu' {  

  class{'::wh_php_apache':;}

  apache::vhost { 'intranet.upr.edu.cu non-ssl':
    servername      => 'intranet.upr.edu.cu',
    serveraliases   => ['www.intranet.upr.edu.cu'],
    port            => '80',
    docroot         => '/home/Intranet/master/',
    custom_fragment => 'Alias /phpmyadmin /usr/share/phpmyadmin',
    directories     => [ {
      'path'           => '/home/Intranet/master',
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
    r10k_basedir => "/home/Intranet",
    cachedir     => "/var/cache/r10k",
    configfile   => "/etc/r10k/r10k.yaml",
    remote       => "git@gitlab.upr.edu.cu:dcenter/intranet_old.git",
    sources      => {
      'News-UPR' => {
        'remote'           => 'git@gitlab.upr.edu.cu:dcenter/intranet_old.git',
        'basedir'          => '/home/Intranet',
        'prefix'           => false,
        'invalid_branches' => 'correct',
    },
  }
  }

}
