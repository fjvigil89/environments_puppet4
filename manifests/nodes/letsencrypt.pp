node 'letsencrypt.upr.edu.cu' {  
    class { '::basesys':
    uprinfo_usage => 'Servidor lets encrypt',
    application   => 'lets encrypt',
    mta_enabled   => false,
    dmz           => true,
  }
  class { '::letsencrypt_host':
    dominios   => ['contable.upr.edu.cu','sync.upr.edu.cu'],
    config_dir => '/etc/letsencrypt',
  }
}
