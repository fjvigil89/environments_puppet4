node 'ha-ftp.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor HAproxy FTP',
    application     => 'HAproxy FTP',
    repos_enabled   => true,
    mta_enabled     => false,
  }

  class {'::haproxy_serv':
    enable_ssl        => false,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'ftp',
    mode              => 'http',
    balancer_member   => ['ftp0','ftp1','ftp2'],
    server_names      => ['ftp0.upr.edu.cu','ftp1.upr.edu.cu','ftp2.upr.edu.cu'],
    ipaddresses       => ['10.2.4.55','10.2.4.56','10.2.4.57'],
    ports             => ['80'],
  }
  haproxy::listen { 'ftp_bhttp':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '80',
  }
  haproxy::balancermember { 'ftp0.upr.edu.cu':
    listening_service => 'ftp_bhttp',
    server_names      => 'ftp0.upr.edu.cu',
    ipaddresses       => '10.2.4.55',
    ports             => '80',
  }
  haproxy::balancermember { 'ftp1.upr.edu.cu':
    listening_service => 'ftp_bhttp',
    server_names      => 'ftp1.upr.edu.cu',
    ipaddresses       => '10.2.4.56',
    ports             => '80',
  }
 haproxy::balancermember { 'ftp2.upr.edu.cu':
   listening_service => 'ftp_bhttp',
   server_names      => 'ftp2.upr.edu.cu',
   ipaddresses       => '10.2.4.57',
   ports             => '80',
 }
}
#Script to update antivirus, crontab
file { '/srv/update.sh':
  ensure => 'absent',
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0774',
  source => 'puppet:///modules/ftpbackend_server/update_antiv/update.sh',
}
cron { 'update_antivirus':
  ensure  => 'absent',
  command => '/srv/update.sh',
  user    => 'root',
  hour    => '5',
  minute  => 'absent',
}

node /^ftp\d+$/ {
  include ftpbackend_server
}

