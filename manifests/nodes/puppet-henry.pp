node 'puppet-henry.upr.edu.cu' {
  #include puppetserver
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor Puppet Master',
    application     => 'Puppet Master Prueba',
    #repos_enabled   => true,
    mta_enabled     => false,
  	puppet_enabled  => false,
	dmz 			=> true,
  }
  class { '::puppet':
  server                => true,
  server_foreman        => false,
  server_reports        => 'store',
  server_external_nodes => '',
}
}
