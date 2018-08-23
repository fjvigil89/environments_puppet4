node 'client-puppet.upr.edu.cu'{
  #class {'::talkserver':;}
  #class {'::mailserver':;}
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
  }
  #class { '::letsencrypt_host':
  #email => 'fjvigil@hispavista.com',
  #webroot_enable => true,
  #dominios => ['sync.upr.edu.cu'],
  #plugin => 'webroot',
  #webroot_paths => ['/root/Sync-UPR/public/'],
  #}
  include dns_secundary

  }
node 'puppet-test.upr.edu.cu'{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
    repos_enabled  => true,
  }
  #include nfs_client
  # class { 'freeradius':
  #max_requests    => 4096,
  #max_servers     => 4096,
  #mysql_support   => true,
  #perl_support    => true,
  #utils_support   => true,
  #wpa_supplicant  => true,
  #winbind_support => true,
  #syslog          => true,
  #log_auth        => 'yes',
  #}
  class {'::dns_bind':}
  #$string = ['/usr/a','/usr/b','/usr/c']
  #each($string) |$value| {
  # file { $value:
  #   ensure => present,
  # }
  #}
}
