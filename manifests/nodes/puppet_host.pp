node 'client-puppet.upr.edu.cu'{
  
  #class {'::talkserver':;}
  #class {'::mailserver':;}

  class { '::basesys':
  uprinfo_usage  => 'servidor test',
  application      => 'puppet',
  puppet_enabled   => false,
  #mta_enabled => false,
  repos_enabled => true;
 
  }

  #class { '::letsencrypt_host':
   #email => 'fjvigil@hispavista.com',
   #webroot_enable => true,
   #dominios => ['sync.upr.edu.cu'],
   #plugin => 'webroot',
   #webroot_paths => ['/root/Sync-UPR/public/'],
  #}
  

 #apache::vhost { 'sync.upr.edu.cu':
  #port     => '443',
  #docroot  => '/home/Sync-UPR/public/',
  #ssl      => true,
  #docroot_owner => 'root',
  #docroot_group => 'root',
 #}

 
	
}
