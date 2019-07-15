node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}~>
  class {'::filebeatserver':
    log_type => "syslog",
  }


}
node /^elk-cluster\d+$/ {
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor ELK',
    application     => 'Cluster ELK',
  }
 class{'elknodeserver:';}
}

