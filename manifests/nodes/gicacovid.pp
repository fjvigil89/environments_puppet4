node 'gicacovid.upr.edu.cu' {

  class { '::basesys':
    uprinfo_usage  => 'servidor GicaCovid',
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
  file { '/home/GicaCovid':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }

  apache::vhost { 'gicacovid.upr.edu.cu non-ssl':
    servername      => 'gicacovid.upr.edu.cu',
    serveraliases   => ['www.gicacovid.upr.edu.cu'],
    port            => '80',
    docroot         => '/home/GicaCovid/master/public',
    custom_fragment => 'Alias /phpmyadmin /usr/share/phpmyadmin',
    directories     => [ {
      'path'           => '/home/GicaCovid/master/public',
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
  }

 class {'r10kserver':
    r10k_basedir => "/home/GicaCovid",
    cachedir     => "/var/cache/r10k",
    configfile   => "/home/r10k.yaml",
    remote       => "git@gitlab.upr.edu.cu:dpto_informatica/gicacovid.git",
    sources      => {
      'News-UPR' => {
        'remote'           => 'git@gitlab.upr.edu.cu:dpto_informatica/gicacovid.git',
        'basedir'          => '/home/GicaCovid',
        'prefix'           => false,
        'invalid_branches' => 'correct',
    },
  }
  }


   class { '::mysql::server':
    root_password           => '*$upr.cuba*$',
    remove_default_accounts => false,
    restart                 => true,
    override_options        => $override_options,

  }
  mysql::db { 'covid':
    user     => 'gicacovid',
    password => 'gicacovid',
    host     => 'localhost',
    # grant    => ['SELECT', 'UPDATE'],
  }

  exec {'/usr/bin/sudo/a2enmod php7.2':
  # cwd => '/usr/bin/sudo',
  }~>
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    #refreshonly => true;
   }
 # exec{"a2enmod_php7":
 #   command => '/usr/bin/sudo a2enmod php7.2',
 # }~>
}
