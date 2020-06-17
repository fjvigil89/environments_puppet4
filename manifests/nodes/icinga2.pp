node 'master-icinga0.upr.edu.cu'{
  class { '::basesys': 
    uprinfo_usage      => 'icinga_server',
    application        => 'icinga2',
    puppet_enabled     => true,
    mta_enabled        => false,
    monitoring_enabled => false;
  }
  class { '::monitoring':;}
  #Copy SSH SSL
  file { '/root/.ssh/id_rsa':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/monitoring/ssh_keys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/monitoring/ssh_keys/id_rsa.pub',
  }
  file { '/root/.ssh/config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/monitoring/ssh_keys/config',
  }

  #include 'exim4'
}
node 'master-icinga1.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage      => 'icinga_server1',
    application        => 'icinga2',
    puppet_enabled     => true,
    mta_enabled        => false,
    monitoring_enabled => false;
  }
  class {'::monitoring':
    icingaweb2server_enabled => false,
  }
}

