node 'smb.upr.edu.cu' {
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
  group { 'dopa':
    ensure => 'present',
  }
  user { 'dopa':
    ensure     => 'present',
    comment    => 'Samba DOPA',
    managehome => true,
    groups     => 'dopa',
    # note the single quotes to stop $ expanding
    #password   => '$6$LD5..snip...gNY1',
  }
  package { 'samba':
    ensure => 'installed',
  }
  service { 'smbd':
    ensure => 'running',
  }
  file {'/srv/dopa':
   ensure => 'directory',
   owner  => 'dopa',
   group  => 'dopa',
   mode   => '0644',
 }
  file { '/etc/samba/smb.conf':
      content => "[DOPA]
comment = Repositorio de DOPA
browseable = yes
path = /srv/dopa
valid users = dopa
read only = no
",
    }
  }
#  apache::vhost { 'dopa.upr.edu.cu non-ssl':
#    servername      => 'dopa.upr.edu.cu',
#    serveraliases   => ['www.dopa.upr.edu.cu'],
#    port            => '80',
#    docroot         => '/srv/dopa/',
#    directories     => [ {
#      'path'           => '/srv/dopa',
#      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
#      'allow_override' => 'All',
#      #'directoryindex' => 'index.php',
#      },
      #{
      #'path'           => '/usr/share/phpmyadmin',
      #'options'        => ['FollowSymLinks'],
      #'allow_override' => 'All',
      #'directoryindex' => 'index.php',
      #},
#    ],
#  }->
#  exec{"a2enmod_php7":
#    command => '/usr/bin/sudo a2enmod php7.0 | /usr/bin/sudo service apache2 restart',
#  }->
#  exec{"service_apache2_restart":
#    command     => '/usr/bin/sudo service apache2 restart',
#    refreshonly => true;
#  }->
#  include apache::mod::php
#}
