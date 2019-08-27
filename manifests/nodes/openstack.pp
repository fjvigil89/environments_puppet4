node 'control.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage   => 'servidor gestion',
    application     => 'Openstack',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
  }


}
node 'nova_neutron.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage   => 'servidor gestion',
    application     => 'Openstack',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
  }

}
