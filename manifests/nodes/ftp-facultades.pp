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
  user { 'info':
    ensure  => 'present',
    comment => 'INFORMATICA',
    groups  => 'facultades',
  }
  user { 'tele':
    ensure  => 'present',
    comment => 'Telecomunicaciones',
    groups  => 'facultades',
  }
  user { 'geo':
    ensure  => 'present',
    comment => 'GEOLOGIA',
    groups  => 'facultades',
  }
  user { 'meca':
    ensure  => 'present',
    comment => 'MACANICA',
    groups  => 'facultades',
  }
  file {'/srv/Informatica':
    ensure => 'directory',
    owner  => 'info',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/Telecomunicaciones':
    ensure => 'directory',
    owner  => 'tele',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/Geologia':
    ensure => 'directory',
    owner  => 'geo',
    group  => 'facultades',
    mode   => '0644',
  }
  file {'/srv/Mecanica':
    ensure => 'directory',
    owner  => 'meca',
    group  => 'facultades',
    mode   => '0644',
  }
  class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Facultades Samba Server",
  interfaces    => "eth0",
  security      => 'user'
}
samba::server::share { 'info':
  comment              => 'Informatica',
  path                 => '/srv/Informatica',
  browsable            => true,
  writable             => true,
  valid_users          => "info",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'tele':
  comment              => 'Telecomunicaciones',
  path                 => '/srv/Telecomunicaciones',
  browsable            => true,
  writable             => true,
  valid_users          => "tele",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'geo':
  comment              => 'Geologia',
  path                 => '/srv/Geologia',
  browsable            => true,
  writable             => true,
  valid_users          => "geo",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'meca':
  comment              => 'Mecanica',
  path                 => '/srv/Mecanica',
  browsable            => true,
  writable             => true,
  valid_users          => "meca",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
  exec { "add smb account for info":
    command => "/bin/echo -e 'adminInfo\\nadminInfo' | /usr/bin/smbpasswd -a info",
    }
    exec { "add smb account for tele":
    command => "/bin/echo -e 'adminTele\\nadminTele' | /usr/bin/smbpasswd -a tele",
    }
    exec { "add smb account for geo":
    command => "/bin/echo -e 'adminGeo\\nadminGeo' | /usr/bin/smbpasswd -a geo",
    }
    exec { "add smb account for meca":
    command => "/bin/echo -e 'adminMeca\\nadminMeca' | /usr/bin/smbpasswd -a meca",
    }
  include apache
  apache::vhost { $fqdn:
    port       => '80',
    docroot    => '/srv/Informatica',
    servername => $fqdn,
    aliases    => 'info',
    }
    apache::vhost { $fqdn:
    port       => '80',
    docroot    => '/srv/Telecomunicaciones',
    servername => $fqdn,
    aliases    => 'tele',
    }
    apache::vhost { $fqdn:
    port       => '80',
    docroot    => '/srv/Mecanica',
    servername => $fqdn,
    aliases    => 'meca',
    }
    apache::vhost { $fqdn:
    port       => '80',
    docroot    => '/srv/Geologia',
    servername => $fqdn,
    aliases    => 'geo',
    }
}
