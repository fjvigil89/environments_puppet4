node 'ansible.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage   => 'servidor ansible',
    application     => 'Ceph',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  }


  include ansible::controller
  include ansible::target
  #ansible::add_to_group { 'frank': }

}
