node '10.2.4.170' {
  include puppetserver
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor Puppet Master',
    application     => 'Puppet Master Prueba',
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
