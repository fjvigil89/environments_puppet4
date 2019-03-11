node 'elk.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor ELK',
    application     => 'ELK',    
    #repos_enabled   => true,
    #mta_enabled     => false,
  }

  class { 'java':
    distribution => 'jdk',
    package      => 'openjdk-8-jdk'
  }
  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
  }
}
