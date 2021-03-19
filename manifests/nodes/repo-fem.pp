node 'repo-fem.upr.edu.cu' {
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
  group { 'info':
    ensure => 'present',
  }
  user { 'fem':
    ensure  => 'present',
    comment => 'Informatico',
    groups  => 'info',
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
  vcsrepo { '/srv/repo':
  ensure   => latest,
  provider => 'git',
  remote   => 'origin',
  source   => {
    'origin' => 'git@gitlab.upr.edu.cu:dcenter/ftp.git',
  },
  revision => 'master',
  }
class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "FEI Samba Server",
  interfaces    => "eth0",
  security      => 'user'
}
samba::server::share { 'repo':
  comment              => 'FEM',
  path                 => '/srv/repo/repo-fem',
  browsable            => true,
  writable             => true,
  valid_users          => "fem",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
exec { "add smb account for fem":
  command => "/bin/echo -e 'adminfem*2021\\nadminfem*2021' | /usr/bin/smbpasswd -a fem",
}
class{'::wh_php_apache':;}
apache::vhost { $fqdn:
  port       => '80',
  docroot    => '/srv/repo',
  servername => $fqdn,
  aliases    => 'repo-fem',
  directories   => [ {
   'path'           => '/srv/repo',
   'options'        => ['Indexes','FollowSymLinks','MultiViews'],
   'allow_override' => 'All',
   'directoryindex' => '/_h5ai/public/index.php',
  },],
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
