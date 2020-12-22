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
    password   => '$6$TEfwqzdhNZL8RbKD$pRCwZFAveROkeXtMahru7fhc24Nh.TOy/./QKAOYHk9rmQs4NJhD/r5xusBrZTcDvhrmgX6shjxiCV4Flz9Uu.',
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
  apache::vhost { 'dopa':
    port       => '80',
    docroot    => '/srv/dopa/',
    servername => 'dopa.upr.edu.cu',
    serveraliases   => ['www.dopa.upr.edu.cu'],
    aliases    => 'mrtg',
    directories     => [{
      'path'           => '/srv/dopa',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      },],
   }
 }
