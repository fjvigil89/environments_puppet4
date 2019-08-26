node 'mx-externo.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor mx-externo',
    application    => 'mx-externo',
    puppet_enabled => false,
    mta_enabled    => false,
  }
  class {'::filebeatserver':
    paths    => '/var/log/mail.log',
    log_type => "correo",
   }
  class {'::metricbeatserver':
    modules  => ['system']
  }

}
