node 'talk.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor Mensajeria Instantanea UPR',
    application    => 'Servidor XMPP ejabberd',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}
