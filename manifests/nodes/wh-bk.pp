node 'wh-bk.upr.edu.cu'{
 
 class{'::wh_php_apache':;} 

 apache::vhost { 'sync.upr.edu.cu non-ssl':
  servername       => 'sync.upr.edu.cu',
  serveraliases => ['www.sync.upr.edu.cu'], 
  port             => '80',
  docroot	   => '/home/Sync-UPR/master/public/',
  directories      => [ {
    'path'    => '/home/Sync-UPR/master/public',
    'options' => ['Indexes','FollowSymLinks','MultiViews'],
    'allow_override'  => 'All',
    'directoryindex' => 'index.php',
    },],

  redirect_status  => 'permanent',
  redirect_dest    => 'https://sync.upr.edu.cu/',
 }~>
 apache::vhost { 'sync.upr.edu.cu ssl':
  servername    => 'sync.upr.edu.cu',
  serveraliases =>  ['www.sync.upr.edu.cu'],
  port          => '443',
  docroot       => '/home/Sync-UPR/master/public/',
  ssl           => true,
  directories =>  [ {
  'path'            => '/home/Sync-UPR/master/public',
  'options'         => ['Indexes','FollowSymLinks','MultiViews'],
  'allow_override'   => 'All',    
  'directoryindex'  => 'index.php',
  },],
 }~> 
 apache::vhost { 'contable.upr.edu.cu non-ssl':
  servername       => 'contable.upr.edu.cu',
  serveraliases => ['www.contable.upr.edu.cu'],
  port             => '80',
  docroot          => '/home/Contable/master/web/',
  directories      => [ {
    'path'    => '/home/Contable/master/web',
    'options' => ['Indexes','FollowSymLinks','MultiViews'],
    'allow_override'  => 'All',
    'directoryindex' => 'app.php',
    },],

  redirect_status  => 'permanent',
  redirect_dest    => 'https://contable.upr.edu.cu/',
 }~> 
 apache::vhost { 'contable.upr.edu.cu ssl':
  servername    => 'contable.upr.edu.cu',
  serveraliases =>  ['www.contable.upr.edu.cu'],
  port          => '443',
  docroot       => '/home/Contable/master/web/',
  ssl           => true,
  directories      => [ {
  'path'    => '/home/Contable/master/web',
  'options' => ['Indexes','FollowSymLinks','MultiViews'],
  'allow_override'  => 'All',
  'directoryindex' => 'app.php',
  },], 

 }~>
 apache::vhost { 'apiassets.upr.edu.cu':
  servername       => 'apiassets.upr.edu.cu',
  serveraliases    => ['www.apiassets.upr.edu.cu'],
  port             => '80',
  docroot          => '/home/Api-Assets/master/web/',
  directories      => [ {
  'path'           => '/home/Api-Assets/master/web',
  #'options'        => ['Indexes','FollowSymLinks','MultiViews'],
  'allow_override' => 'All',
  'allow'          => 'from All',
  'directoryindex' => 'app.php',
  },],
 }~>
 file{'/etc/apache2/sites-available/25-apiassets2.upr.edu.cu.conf':
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/php_webserver/25-apiassets.upr.edu.cu.conf',
  }~>
 exec{"a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
 }~>
 exec{"service_apache2_restart":
  command => '/usr/bin/sudo service apache2 restart',
 }
 


 

}

