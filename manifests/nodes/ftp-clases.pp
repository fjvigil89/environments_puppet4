node 'teleclases.upr.edu.cu' {
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

  group { 'clases':
    ensure => 'present',
  }
  user { 'clases':
    ensure  => 'present',
    comment => 'Clases',
    groups  => 'clases',
  }
  user { 'ipvce':
    ensure  => 'present',
    comment => 'IPVCE',
    groups  => 'clases',
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
  file {'/srv/ftp/teleclases-Mined':
    ensure => 'directory',
    owner  => 'clases',
    group  => 'clases',
    mode   => '0644',
  }
  file {'/srv/ftp/IPVCE':
    ensure => 'directory',
    owner  => 'ipvce',
    group  => 'clases',
    mode   => '0644',
  }
class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Teleclases Samba Server",
  interfaces    => "eth0",
  security      => 'user'
}
samba::server::share { 'clases':
  comment              => 'CLASES',
  path                 => '/srv/ftp/teleclases-Mined',
  browsable            => true,
  writable             => true,
  valid_users          => "clases",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
samba::server::share { 'IPVCE':
  comment              => 'IPVCE',
  path                 => '/srv/ftp/IPVCE',
  browsable            => true,
  writable             => true,
  valid_users          => "ipvce",
  create_mask          => 755,
  directory_mask       => 2775,
  force_directory_mode => 2775,
}
exec { "add smb account for clases":
  command => "/bin/echo -e 'adminclases\\nadminclases' | /usr/bin/smbpasswd -a clases",
}
exec { "add smb account for ipvce":
  command => "/bin/echo -e 'adminipvce\\nadminipvce' | /usr/bin/smbpasswd -a ipvce",
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
exec { "a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}~>
exec { "service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}
include apache::mod::php
}
