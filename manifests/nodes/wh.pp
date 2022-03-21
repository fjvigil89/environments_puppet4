node 'wh.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage => 'servidor wh',
    application   => 'wh',
    mta_enabled   => false,
    puppet_users  => false,
  }
}
