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
  aptly::mirror { 'debian_stable':
    location      => 'http://repos.uclv.edu.cu',
    distribution  => 'stable',
    components    => [ 'main' ],
    architectures => ['amd64'],
  }
}
