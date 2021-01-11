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
    #managehome => true,
    groups  => 'notas',
    # note the single quotes to stop $ expanding
    #password   => '$6$TEfwqzdhNZL8RbKD$pRCwZFAveROkeXtMahru7fhc24Nh.TOy/./QKAOYHk9rmQs4NJhD/r5xusBrZTcDvhrmgX6shjxiCV4Flz9Uu.',
  }
  class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Media Samba Server",
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
  #package { 'samba':
  #  ensure => 'installed',
  #}
#  service { 'smbd':
#    enable => true,
#    ensure => 'running',
#  }
  exec { "add smb account for dopa":
    command => "/bin/echo -e 'notasPI\\nnotasPI' | /usr/bin/smbpasswd -a notas",
    }
  service { 'smbd':
    enable => true,
    ensure => 'running',
  }
  apache::vhost { '$fqdn':
    port       => '80',
    docroot    => '/srv/notas',
    servername => $fqdn,
    serveraliases   => ["www.${fqdn}"],
    #aliases    => 'notas',
    #directories     => {
    #  'path'           => '/srv/notas',
    #  'options'        => ['Indexes','FollowSymLinks','MultiViews'],
    #  'allow_override' => 'All',
    #  },
  }
}
#  file { '/etc/samba/smb.conf':
#      content => "[DOPA]
#comment = Repositorio de DOPA
#browseable = yes
#path = /srv/dopa
#valid users = dopa
#read only = no
#",
#}

