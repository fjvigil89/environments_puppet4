node 'ircserver.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor IRC UPR',
    application    => 'IRC- Unreal',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
node 'ircportal.upr.edu.cu' {
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor IRC UPR',
    application    => 'IRC - Services',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}

