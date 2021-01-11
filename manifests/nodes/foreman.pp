node 'foreman.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor foreman',
    application    => 'Foreman',    
    repos_enabled  => false,
    dns_preinstall => true,
  }


}
