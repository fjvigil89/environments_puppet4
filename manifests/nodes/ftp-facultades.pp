node 'ftp-facultades.upr.edu.cu' {
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
  file {'/srv/fct':
    ensure => 'directory',
    owner  => 'fct',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/fcfa':
    ensure => 'directory',
    owner  => 'fcfa',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/fcee':
    ensure => 'directory',
    owner  => 'fcee',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/fcsh':
    ensure => 'directory',
    owner  => 'fcsh',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/fei':
    ensure => 'directory',
    owner  => 'fei',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/fem':
    ensure => 'directory',
    owner  => 'fem',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/fcf':
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
  path                 => '/srv/fct',
  browsable            => true,
  writable             => true,
  valid_users          => "fct",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcfa':
  comment              => 'FCFA',
  path                 => '/srv/fcfa',
  browsable            => true,
  writable             => true,
  valid_users          => "fcfa",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcee':
  comment              => 'FCEE',
  path                 => '/srv/fcee',
  browsable            => true,
  writable             => true,
  valid_users          => "fcee",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcsh':
  comment              => 'FCSH',
  path                 => '/srv/fcsh',
  browsable            => true,
  writable             => true,
  valid_users          => "fcsh",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fei':
  comment              => 'FEI',
  path                 => '/srv/fei',
  browsable            => true,
  writable             => true,
  valid_users          => "fei",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fem':
  comment              => 'FEM',
  path                 => '/srv/fem',
  browsable            => true,
  writable             => true,
  valid_users          => "fem",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'fcf':
  comment              => 'FCF',
  path                 => '/srv/fcf',
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
  include apache
  apache::vhost { 'fct':
    port       => '80',
    docroot    => '/srv/fct',
    servername => 'ftp-fct.upr.edu.cu',
    aliases    => 'fct',
    }
  apache::vhost { 'fcfa':
    port       => '80',
    docroot    => '/srv/fcfa',
    servername => 'ftp-fcfa.upr.edu.cu',
    aliases    => 'fcfa',
    }
  apache::vhost { 'fcee':
    port       => '80',
    docroot    => '/srv/fcee',
    servername => 'ftp-fcee.upr.edu.cu',
    aliases    => 'fcee',
    }
  apache::vhost { 'fcsh':
    port       => '80',
    docroot    => '/srv/fcsh',
    servername => 'ftp-fcsh.upr.edu.cu',
    aliases    => 'fcsh',
    }
  apache::vhost { 'fei':
    port       => '80',
    docroot    => '/srv/fei',
    servername => 'ftp-fei.upr.edu.cu',
    aliases    => 'fei',
    }
  apache::vhost { 'fem':
    port       => '80',
    docroot    => '/srv/fem',
    servername => 'ftp-fem.upr.edu.cu',
    aliases    => 'fem',
    }
  apache::vhost { 'fcf':
    port       => '80',
    docroot    => '/srv/fem',
    servername => 'ftp-fcf.upr.edu.cu',
    aliases    => 'fcf',
    }
}