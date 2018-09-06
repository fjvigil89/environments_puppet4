node 'client-puppet.upr.edu.cu'{
  #class {'::talkserver':;}
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',  
    repos_enabled => false, 
     
  }
  #class { '::letsencrypt_host':
  #email => 'fjvigil@hispavista.com',
  #webroot_enable => true,
  #dominios => ['sync.upr.edu.cu'],
  #plugin => 'webroot',
  #webroot_paths => ['/root/Sync-UPR/public/'],
  #}
  #class {'dhcpserver':
  #    interfaces   => ['eth0'],
  #    pool_enabled => true,
  #    pool         => ['Assets'],
  #    network      => ['10.2.202.0'],
  #    mask         => ['255.255.255.0'],
  #    range        => ['10.2.202.2 10.2.202.5'],
  #    gateway      => ['10.2.202.1'],
  #    host_enabled => true,
  #    host         => ['profes.upr.edu.cu'],
  #    comment      => ['este es el host para el proxy de profesores'],
  #    mac          => ['72:92:c5:24:74:e4'],
  #    ip           => ['10.2.202.3']
  #  }
 
  #include dns_primary
 
 class { 'postgresql::server':
	}
 postgresql::server::db { 'roundcube':
  user     => 'roundcube',
  password => postgresql_password('roundcube', 'secret'),
 }
 #class { 'roundcube':
 #   db_type     => 'pgsql',
 #   db_name     => 'roundcube',
 #   db_host     => 'localhost',
 #   db_username => 'roundcube',
 #   db_password => 'secret',
 #  plugins => [  
 #    'emoticons',
 #     'markasjunk',
 #     'password',
 #   ],
 # }

}


node 'puppet-test.upr.edu.cu'{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
    epos_enabled  => true,
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
  #class {'::dns_bind':}
  #$string = ['/usr/a','/usr/b','/usr/c']
  #each($string) |$value| {
  # file { $value:
  #   ensure => present,
  # }
  #}
  include dns_secundary
}
