node 'jitsi.upr.edu.cu' { 
  class { '::basesys':
    uprinfo_usage   => 'Servidor de Servicio Jitsi',
    application     => 'Jitsi',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
  }
}
