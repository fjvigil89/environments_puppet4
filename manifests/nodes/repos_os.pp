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
    dns_preinstall  => true,
  }

  class {'::r10kserver' :
     r10k_basedir    => "/root/repos",
     #cachedir        => "/var/cache/r10k",
     configfile      => "/root/r10k.yaml",
     remote          => "git@gitlab.upr.edu.cu:dcenter/repos.git",
  }
}
