node 'comunidad.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage   => 'Foro',
    application     => 'Foro Comunidad',
    proxmox_enabled => true,
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
