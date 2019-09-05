node 'puppet-henry.upr.edu.cu' {
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'Servidor Puppet Master',
    application   => 'Puppetlab',
    repos_enabled => true,
    mta_enabled   => false,
  }
  include puppetdevserver
}
