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
    version => "7.1",
    packages => ["php7.1","php7.1-mbstring","php7.1-cli","php7.1-curl","php7.1-intl","php7.1-ldap","php7.1-mysql","php7.1-sybase","libapache2-mod-php7.1","yarn","php7.1-zip","phpmyadmin"],
    before        => Exec['a2enmod_php7'],
    notify        => Exec['service_apache2_restart'];
  }

  #  class {'phpmyadmin_local':
  #  ensure        => present,
  #  version       => '5.0.4',
  #  root_password => '*$upr.cuba*$',
  #  before        => Exec['a2enmod_php7.3'],
  #  notify        => Exec['service_apache2_restart'];
  #}
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
  }

   class { '::mysql::server':
    root_password           => '*$upr.cuba*$',
    remove_default_accounts => false,
    restart                 => true,
    override_options        => $override_options,

  }

 exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod php7.3 | /usr/bin/sudo a2enmod rewrite ',
  }
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
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
