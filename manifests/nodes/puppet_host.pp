node 'client-puppet.upr.edu.cu'{
  #include puppetprodserver

class { '::basesys':
    uprinfo_usage  => 'test of puppet',
    application      => 'puppet',
    puppet_enabled   => false;
  }
}
