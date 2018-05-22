node 'wh-bk.upr.edu.cu'{
 
 class{'::wh_php_apache':;} 

 apache::vhost { 'sync.upr.edu.cu non-ssl':
  servername       => 'sync.upr.edu.cu',
  port             => '80',
  docroot          => '/home/Sync-UPR/master/public/',
  redirect_status  => 'permanent',
  redirect_dest    => 'https://sync.upr.edu.cu/',
  fallbackresource => '/index.php',
  file_type        => 'application/x-httpd-php',
 }

 apache::vhost { 'sync.upr.edu.cu ssl':
  servername       => 'sync.upr.edu.cu',
  port             => '443',
  docroot          => '/home/Sync-UPR/master/public/',
  ssl              => true,
  fallbackresource => '/index.php',
  file_type        => 'application/x-httpd-php',
 } 

 apache::vhost { 'contable.upr.edu.cu':
  port     => '443',
  docroot  => '/home/Contable/master/public/',
  ssl      => true,
  docroot_owner => 'root',
  docroot_group => 'root',
 }

 apache::vhost { 'apiassets.upr.edu.cu':
  port     => '80',
  docroot  => '/home/Api-Assets/master/public/',
  ssl      => false,
  docroot_owner => 'root',
  docroot_group => 'root',
 }

}

