node 'repos.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor repositorio paquetes SO',
    application     => 'debmirror',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
    dns_preinstall  => true,
  }
  #aptly::mirror { 'debian_stable':
  #  location      => 'http://repos.uclv.edu.cu',
  #  distribution  => 'stable',
  #  components    => [ 'main' ],
  #  architectures => ['amd64'],
  #}
}
