node 'repos.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor repositorio paquetes SO',
    application     => 'debmirror',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
  }
  class { 'debmirror':
    ensure        => 'present',
    allowed_hosts => ['10.2.0.0/15', '200.14.49.0/27', '200.55.143.8/29'],
    datadir       => '/srv/repos',
  }
  debmirror::repository { 'debian':
    ensure => 'present',
    mirror => 'repos.uclv.edu.cu',
    arch   => 'amd64',
    hour   => '5',
    minute => '05',
    cron   => 'yes',
  }
}
