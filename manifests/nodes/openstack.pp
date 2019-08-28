node 'ostack0.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage   => 'Servidor OpenStack',
    application     => 'OpenStack',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
  }
  include ::openstack::role::controller
}
