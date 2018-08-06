node 'android.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor app android',
    application    => 'Servidor Andriod App',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
