node /^gestion\d+$/ {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor info-dl',
    application    => 'Servidor Info-dl',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
