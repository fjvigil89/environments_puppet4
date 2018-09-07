node 'cas.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'Servidor CAS',
    application    => 'Servidor CAS para authentication',
    repos_enabled  => false,
  }
  
  class { "cas::war":
    maven_dir => "/srv/cas-maven",
    build => true
  }
  class {'::casserver':;}
}
