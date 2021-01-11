node 'ftp-notas.upr.edu.cu' {
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
  group { 'notas':
    ensure => 'present',
  }
  user { 'notas':
    ensure  => 'present',
    comment => 'NOTAS',
    groups  => 'notas',
  }
  file {'/srv/notas':
    ensure => 'directory',
    owner  => 'notas',
    group  => 'notas',
    mode   => '0644',
  }
  class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Notas Samba Server",
  interfaces    => "eth0",
  security      => 'user'
}
samba::server::share { 'notas':
  comment              => 'Notas',
  path                 => '/srv/notas',
  browsable            => true,
  writable             => true,
  valid_users          => "notas",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
  exec { "add smb account for dopa":
    command => "/bin/echo -e 'notasPI\\nnotasPI' | /usr/bin/smbpasswd -a notas",
    }
  include apache
  apache::vhost { 'notas':
    port       => '80',
    docroot    => '/srv/notas/',
    servername => 'ftp-notas.upr.edu.cu',
    aliases    => 'notas',
#   serveraliases   => ["www.${fqdn}"],
    #directories     => {
    #  'path'           => '/srv/notas',
    #  'options'        => ['Indexes','FollowSymLinks','MultiViews'],
    #  'allow_override' => 'All',
    #  },
    }
}
