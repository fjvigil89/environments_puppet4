node 'ansible.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage   => 'servidor ansible',
    application     => 'Ceph',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  }


  class { 'ansible':
  ensure           => 'present',
  roles_path       => '/etc/ansible/roles',
  timeout          => 30,
  log_path         => '/var/log/ansible.log',
  private_key_file => '/root/.ssh/id_rsa.pub',
  #  inventory        => './environments/production',
}
  ansible::hosts { 'production':
    entrys  => [
      'ansible.upr.edu.cu',
    ]
  }


}
