node 'wh-bk.upr.edu.cu'{
 
 class{'::wh_php_apache':;} 

 apache::vhost { 'sync.upr.edu.cu':
  servername       => 'sync.upr.edu.cu',
  serveraliases => ['www.sync.upr.edu.cu'], 
  port             => '80',
  docroot	   => '/home/Sync-UPR/master/public/',
  docroot_owner    => 'root',
  docroot_group    => 'root',
  directories      => [ {
    path    => '/home/Sync-UPR/master/public',
    #options => ['Indexes','FollowSymLinks','MultiViews'],
    allowoverride  => 'All',
    allowfrom     => 'All',
    directoryindex => 'index.php index.html ',
    },],

  # redirect_status  => 'permanent',
  #redirect_dest    => 'https://sync.upr.edu.cu/',
 }

 
 apache::vhost { 'contable.upr.edu.cu':
  servername       => 'contable.upr.edu.cu',
  serveraliases => ['www.contable.upr.edu.cu'],
  port             => '80',
  docroot          => '/home/Contable/master/web/',
  docroot_owner    => 'root',
  docroot_group    => 'root',
  suphp_addhandler => 'x-httpd-php',
  suphp_engine     => 'on',
  suphp_configpath => '/etc/php/7.0/apache2', 
  directories      => [ {
    path    => '/home/Contable/master/web',
    #options => ['Indexes','FollowSymLinks','MultiViews'],
    allowoverride  => 'All',
    allowfrom     => 'All',
    directoryindex => 'app.php app.html ',
    },],

  # redirect_status  => 'permanent',
  #redirect_dest    => 'https://contable.upr.edu.cu/',
 }
 


}

