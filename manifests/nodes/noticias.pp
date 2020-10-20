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
  file { '/home/News-UPR':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }
  class{'::wh_php_apache':
    version => "7.3",
    packages => ["php7.3","php7.3-mbstring","php7.3-cli","php7.3-curl","php7.3-intl","php7.3-ldap","php7.3-mysql","php7.3-sybase","libapache2-mod-php7.3","yarn","php7.3-zip"],
  }
 
 class { 'phpmyadmin':
   path     => "/usr/share/phpmyadmin",
   user     => "www-data",
 }
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
  exec{"a2enmod_php7.3":
    command => '/usr/bin/sudo a2enmod php7.3 | /usr/bin/sudo a2enmod rewrite ',
  }->
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
  }->

  class { '::mysql::server':
    root_password           => '*$upr.cuba*$',
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
      ##news.cuba
      password => '$6$U85EKS1f$Ccdr/Qar1Em6VxWwPYlwx8uKM1sBGb1dEEc1hATi4ZlpkTRYCcz.X38ZXeq5ok/I.zEwVtjVMh.YTLVOBMXTL0',
    }
}
