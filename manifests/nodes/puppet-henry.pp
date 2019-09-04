node 'puppet-henry.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor HAproxy FTP',
    application     => 'HAproxy FTP',
    repos_enabled   => true,
    mta_enabled     => false,
  }
}
