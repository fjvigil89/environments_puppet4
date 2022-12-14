node 'tf-noticias.upr.edu.cu' {

  class { '::basesys':
    uprinfo_usage  => 'servidor News',
    application    => 'puppet',
    puppet_enabled => true,
    mta_enabled    => false,
    dns_preinstall => true,
  }

  class{'::wh_php_apache':
    version => "7.2",
    packages => ["php7.2","php7.2-mbstring","php7.2-cli","php7.2-curl","php7.2-intl","php7.2-ldap","php7.2-mysql","php7.2-sybase","libapache2-mod-php7.2","php7.2-zip","phpmyadmin"],
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
  mysql::db { 'noticias':
    user     => 'dbnews',
    password => 'news.cuba',
    host     => 'localhost',
    # grant    => ['SELECT', 'UPDATE'],
  }
  user { news:
      ensure => present,
      ##news.cuba
      password => '$6$U85EKS1f$Ccdr/Qar1Em6VxWwPYlwx8uKM1sBGb1dEEc1hATi4ZlpkTRYCcz.X38ZXeq5ok/I.zEwVtjVMh.YTLVOBMXTL0',
    }

  exec{"update-alternatives":
    command => '/usr/bin/sudo update-alternatives --set php /usr/bin/php7.2 ',
  }->
  exec{"a2dismod_mpm_event":
    command => '/usr/bin/sudo a2dismod mpm_event ',
  }->
  exec{"a2dismod_mpm_worker":
    command => '/usr/bin/sudo a2dismod mpm_worker ',
  }->
 exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod mpm_prefork ',
  }->
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
   }

}
