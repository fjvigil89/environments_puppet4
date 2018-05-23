node 'wh-bk.upr.edu.cu'{
 
 class{'::wh_php_apache':;} 

 apache::vhost { 'sync.upr.edu.cu':
  servername       => 'sync.upr.edu.cu',
  port             => '80',
  docroot	   => '/home/Sync-UPR/master/public/',
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
  port             => '80',
  docroot          => '/home/Contable/master/public/',
  directories      => [ {
    path    => '/home/Contable/master/public',
    #options => ['Indexes','FollowSymLinks','MultiViews'],
    allowoverride  => 'All',
    allowfrom     => 'All',
    directoryindex => 'index.php index.html ',
    },],

  # redirect_status  => 'permanent',
  #redirect_dest    => 'https://contable.upr.edu.cu/',
 }
 


}

