node 'profesor.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage      => 'icinga_server',
    application        => 'icinga2',
    puppet_enabled     => true,
    mta_enabled        => false,
    monitoring_enabled => false;
  }
  class { '::monitoring':;}
}
