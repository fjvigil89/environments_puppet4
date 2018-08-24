node 'repos.upr.edu.cu' {  
    class { '::basesys':
    uprinfo_usage  => 'Servidor Repositorio de Paquetes Linux',
    application    => 'Repositorios debmirro,lftp.rsync',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
