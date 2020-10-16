node 'tf-noticias.upr.edu.cu' {

  class { '::basesys':
    uprinfo_usage  => 'servidor News',
    application    => 'puppet',
    puppet_enabled => true,
    mta_enabled    => false,
    dns_preinstall => true,
  }

  #SSH
  file { '/root/.ssh/id_rsa':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/reposserver/ssh_keys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/reposserver/ssh_keys/id_rsa.pub',
  }
  file { '/root/.ssh/config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/reposserver/ssh_keys/config',
  }
  file { '/etc/r10k':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }
  file { '/home/News-UPR':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }
  class{'::wh_php_apache':;}
  
  apache::vhost { 'noticias.upr.edu.cu non-ssl':
    servername      => 'noticias.upr.edu.cu',
    serveraliases   => ['www.noticias.upr.edu.cu'],
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
      #redirect_dest    => 'https://noticias.upr.edu.cu/',
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


  class { '::mysql::server':
    root_password           => 'news.cuba',
    remove_default_accounts => false,
    restart                 => true,
    override_options        => $override_options
  }

  mysql::db { 'noticias':
  user     => 'news',
  password => 'news.cuba',
  host     => 'localhost',
  # grant    => ['SELECT', 'UPDATE'],
}

    user { news:
      ensure => present,
      password => '!!',
    }
}
