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
  vcsrepo { '/srv/ftp':
  ensure   => latest,
  provider => 'git',
  remote   => 'origin',
  source   => {
    'origin' => 'git@gitlab.upr.edu.cu:dcenter/ftp.git',
  },
  revision => 'master',
}
  #file {'/srv/ftp':
  #  ensure => 'directory',
  #  owner  => 'facultades',
  #  group  => 'facultades',
  #  mode   => '0755',
  #}
  file {'/srv/ftp/fct':
    ensure => 'directory',
    owner  => 'fct',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/ftp/fcfa':
    ensure => 'directory',
    owner  => 'fcfa',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/ftp/fcee':
    ensure => 'directory',
    owner  => 'fcee',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/ftp/fcsh':
    ensure => 'directory',
    owner  => 'fcsh',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/ftp/fei':
    ensure => 'directory',
    owner  => 'fei',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/ftp/fem':
    ensure => 'directory',
    owner  => 'fem',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/ftp/fcf':
    ensure => 'directory',
    owner  => 'fcf',
    group  => 'facultades',
    mode   => '0644',
  }

class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Facultades Samba Server",
  interfaces    => "eth0",
  security      => 'user'
}
samba::server::share { 'fct':
  comment              => 'FCFA',
  path                 => '/srv/ftp/fct',
  browsable            => true,
  writable             => true,
  valid_users          => "fct",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcfa':
  comment              => 'FCFA',
  path                 => '/srv/ftp/fcfa',
  browsable            => true,
  writable             => true,
  valid_users          => "fcfa",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcee':
  comment              => 'FCEE',
  path                 => '/srv/ftp/fcee',
  browsable            => true,
  writable             => true,
  valid_users          => "fcee",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcsh':
  comment              => 'FCSH',
  path                 => '/srv/ftp/fcsh',
  browsable            => true,
  writable             => true,
  valid_users          => "fcsh",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fei':
  comment              => 'FEI',
  path                 => '/srv/ftp/fei',
  browsable            => true,
  writable             => true,
  valid_users          => "fei",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fem':
  comment              => 'FEM',
  path                 => '/srv/ftp/fem',
  browsable            => true,
  writable             => true,
  valid_users          => "fem",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcf':
  comment              => 'FCF',
  path                 => '/srv/ftp/fcf',
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
  class{'::wh_php_apache':;}
  apache::vhost { $fqdn:
    port       => '80',
    docroot    => '/srv/ftp',
    servername => $fqdn,
    aliases    => 'facultades',
    directories   => [ {
    'path'           => '/srv/ftp',
    'options'        => ['Indexes','FollowSymLinks','MultiViews'],
    'allow_override' => 'All',
    'directoryindex' => '/_h5ai/public/index.php',
    },],
  }
  apache::vhost { 'fct':
    port       => '80',
    docroot    => '/srv/ftp/fct',
    servername => 'ftp-fct.upr.edu.cu',
    aliases    => 'fct',
    }
  apache::vhost { 'fcfa':
    port       => '80',
    docroot    => '/srv/ftp/fcfa',
    servername => 'ftp-fcfa.upr.edu.cu',
    aliases    => 'fcfa',
    }
  apache::vhost { 'fcee':
    port       => '80',
    docroot    => '/srv/ftp/fcee',
    servername => 'ftp-fcee.upr.edu.cu',
    aliases    => 'fcee',
    }
  apache::vhost { 'fcsh':
    port       => '80',
    docroot    => '/srv/ftp/fcsh',
    servername => 'ftp-fcsh.upr.edu.cu',
    aliases    => 'fcsh',
    }
  apache::vhost { 'fei':
    port       => '80',
    docroot    => '/srv/ftp/fei',
    servername => 'ftp-fei.upr.edu.cu',
    aliases    => 'fei',
    }
  apache::vhost { 'fem':
    port       => '80',
    docroot    => '/srv/ftp/fem',
    servername => 'ftp-fem.upr.edu.cu',
    aliases    => 'fem',
    }
  apache::vhost { 'fcf':
    port       => '80',
    docroot    => '/srv/ftp/fem',
    servername => 'ftp-fcf.upr.edu.cu',
    aliases    => 'fcf',
    }
  exec { "a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
  }~>
  exec { "service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
  }
  include apache::mod::php
}
