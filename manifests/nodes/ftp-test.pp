node 'ftp-test.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage   => 'Samba',
    application     => 'CT',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => false,
    puppet_enabled  => true,
    dns_preinstall  => true,
  }
  group { 'facultades':
    ensure => 'present',
  }
  user { 'facultades':
    ensure  => 'present',
    comment => 'Facultades',
    groups  => 'facultades',
  }
  user { 'fct':
    ensure  => 'present',
    comment => 'FCT',
    groups  => 'facultades',
  }
  user { 'fcfa':
    ensure  => 'present',
    comment => 'FCFA',
    groups  => 'facultades',
  }
  user { 'fcee':
    ensure  => 'present',
    comment => 'FCEE',
    groups  => 'facultades',
  }
  user { 'fcsh':
    ensure  => 'present',
    comment => 'FCSH',
    groups  => 'facultades',
  }
  user { 'fei':
    ensure  => 'present',
    comment => 'FEI',
    groups  => 'facultades',
  }
  user { 'fem':
    ensure  => 'present',
    comment => 'FEM',
    groups  => 'facultades',
  }
  user { 'fcf':
    ensure  => 'present',
    comment => 'FCF',
    groups  => 'facultades',
  }
  #file {'/srv/facultades':
  #  ensure => 'directory',
  #  owner  => 'facultades',
  #  group  => 'facultades',
  #  mode   => '0644',
  #}
  vcsrepo { '/srv/facultades':
  ensure   => latest,
  provider => 'git',
  remote   => 'origin',
  source   => {
    'origin' => 'git@gitlab.upr.edu.cu:dcenter/ftp.git',
  },
  revision => 'master',
}
  file {'/srv/facultades/fct':
    ensure => 'directory',
    owner  => 'fct',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/facultades/fcfa':
    ensure => 'directory',
    owner  => 'fcfa',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/facultades/fcee':
    ensure => 'directory',
    owner  => 'fcee',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/facultades/fcsh':
    ensure => 'directory',
    owner  => 'fcsh',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/facultades/fei':
    ensure => 'directory',
    owner  => 'fei',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/facultades/fem':
    ensure => 'directory',
    owner  => 'fem',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/facultades/fcf':
    ensure => 'directory',
    owner  => 'fcf',
    group  => 'facultades',
    mode   => '0644',
  }
  #Copy SSH Key
file { '/root/.ssh/id_rsa':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0600',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/id_rsa',
}
file { '/root/.ssh/id_rsa.pub':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/id_rsa.pub',
}
file { '/root/.ssh/config':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/config',
}
#include git
class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Facultades Samba Server",
  interfaces    => "eth0",
  security      => 'user'
}
samba::server::share { 'fct':
  comment              => 'FCFA',
  path                 => '/srv/facultades/fct',
  browsable            => true,
  writable             => true,
  valid_users          => "fct",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcfa':
  comment              => 'FCFA',
  path                 => '/srv/facultades/fcfa',
  browsable            => true,
  writable             => true,
  valid_users          => "fcfa",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcee':
  comment              => 'FCEE',
  path                 => '/srv/facultades/fcee',
  browsable            => true,
  writable             => true,
  valid_users          => "fcee",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcsh':
  comment              => 'FCSH',
  path                 => '/srv/facultades/fcsh',
  browsable            => true,
  writable             => true,
  valid_users          => "fcsh",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fei':
  comment              => 'FEI',
  path                 => '/srv/facultades/fei',
  browsable            => true,
  writable             => true,
  valid_users          => "fei",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fem':
  comment              => 'FEM',
  path                 => '/srv/facultades/fem',
  browsable            => true,
  writable             => true,
  valid_users          => "fem",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcf':
  comment              => 'FCF',
  path                 => '/srv/facultades/fcf',
  browsable            => true,
  writable             => true,
  valid_users          => "fcf",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
  exec { "add smb account for fct":
    command => "/bin/echo -e 'adminfct\\nadminfct' | /usr/bin/smbpasswd -a fct",
    }
  exec { "add smb account for fcfa":
    command => "/bin/echo -e 'adminfcfa\\nadminfcfa' | /usr/bin/smbpasswd -a fcfa",
    }
  exec { "add smb account for fcee":
    command => "/bin/echo -e 'adminfcee\\nadminfcee' | /usr/bin/smbpasswd -a fcee",
    }
  exec { "add smb account for fcsh":
    command => "/bin/echo -e 'adminfcsh\\nadminfcsh' | /usr/bin/smbpasswd -a fcsh",
    }
  exec { "add smb account for fei":
    command => "/bin/echo -e 'adminfei\\nadminfei' | /usr/bin/smbpasswd -a fei",
    }
  exec { "add smb account for fem":
    command => "/bin/echo -e 'adminfem\\nadminfem' | /usr/bin/smbpasswd -a fem",
    }
  exec { "add smb account for fcf":
    command => "/bin/echo -e 'adminfcf\\nadminfcf' | /usr/bin/smbpasswd -a fcf",
    }
  #include apache
  class { '::php_webserver':
     php_version    => '7.4',
     php_extensions => {
      'curl'     => {},
      'gd'       => {},
      'mysql'    => {},
      'ldap'     => {},
      'xml'      => {},
      'mbstring' => {},
     },
     packages       =>  ['php7.4-mbstring','php7.4','php7.4-cli','php7.4-curl','php7.4-intl','php7.4-ldap','php7.4-mysql','php7.4-sybase','libapache2-mod-php7.4','php7.4-mcrypt','phpmyadmin','freetds-bin','freetds-common'],
  }
  apache::vhost { $fqdn:
    port       => '80',
    docroot    => '/srv/facultades',
    servername => $fqdn,
    aliases    => 'facultades',
    suphp_engine     => 'off',
    directories   => [ {
      'path'           => '/srv/facultades/_h5ai/public/',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },],
  }
  apache::vhost { 'fct':
    port       => '80',
    docroot    => '/srv/facultades/fct',
    servername => 'ftp-fct.upr.edu.cu',
    aliases    => 'fct',
    }
  apache::vhost { 'fcfa':
    port       => '80',
    docroot    => '/srv/facultades/fcfa',
    servername => 'ftp-fcfa.upr.edu.cu',
    aliases    => 'fcfa',
    }
  apache::vhost { 'fcee':
    port       => '80',
    docroot    => '/srv/facultades/fcee',
    servername => 'ftp-fcee.upr.edu.cu',
    aliases    => 'fcee',
    }
  apache::vhost { 'fcsh':
    port       => '80',
    docroot    => '/srv/facultades/fcsh',
    servername => 'ftp-fcsh.upr.edu.cu',
    aliases    => 'fcsh',
    }
  apache::vhost { 'fei':
    port       => '80',
    docroot    => '/srv/facultades/fei',
    servername => 'ftp-fei.upr.edu.cu',
    aliases    => 'fei',
    }
  apache::vhost { 'fem':
    port       => '80',
    docroot    => '/srv/facultades/fem',
    servername => 'ftp-fem.upr.edu.cu',
    aliases    => 'fem',
    }
  apache::vhost { 'fcf':
    port       => '80',
    docroot    => '/srv/facultades/fem',
    servername => 'ftp-fcf.upr.edu.cu',
    aliases    => 'fcf',
    }
  exec { "a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.4',
}~>
exec { "service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}
}
