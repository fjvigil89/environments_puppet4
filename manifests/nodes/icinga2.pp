node 'master-icinga0.upr.edu.cu'{
  include icinga2_server
}
node 'master-icinga1.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage      => 'icinga_server1',
    application        => 'icinga2',
    puppet_enabled     => true,
    mta_enabled        => false,
    monitoring_enabled => false;
  }
}

