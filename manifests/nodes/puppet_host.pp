node 'client-puppet.upr.edu.cu'{
  
  #class {'::talkserver':;}
  #class {'::mailserver':;}

  class { '::basesys':
  uprinfo_usage  => 'servidor test',
  application      => 'puppet',
  puppet_enabled   => false,
  mta_enabled => false,
  repos_enabled => false;
 
  }

  #class { '::letsencrypt_host':
   #email => 'fjvigil@hispavista.com',
   #webroot_enable => true,
   #dominios => ['sync.upr.edu.cu'],
   #plugin => 'webroot',
   #webroot_paths => ['/root/Sync-UPR/public/'],
  #}

 include git
 class { 'apache':
  default_vhost => false,
 } 
 apache::vhost { 'sync.upr.edu.cu':
  port     => '443',
  docroot  => '/home/Sync-UPR/public/',
  ssl      => true,
  docroot_owner => 'root',
  docroot_group => 'root',
 } 


  class { '::php_webserver':
    php_version    => '7.0',
    php_extensions => {
      'curl'     => {},
      'gd'       => {},
      'mysql'    => {},
      'ldap'     => {},
      'xml'      => {},
      'mbstring' => {},
     
    #,
    packages => ['php7.0-mbstring','r10k'],
  }

  # Define TimeZone in php
  file_line { 'extension=php_ldap':
   path   => '/etc/php/7.0/cli/php.ini',
   line   => 'extension=php_ldap.dll',
   #match  => '^date.timezone =',
   notify =>  Class['php_webserver'],
 }


}
