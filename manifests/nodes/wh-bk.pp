node 'wh-bk.upr.edu.cu'{
 
 class{'::wh_php_apache':;} 

 apache::vhost { 'sync.upr.edu.cu':
  servername       => 'sync.upr.edu.cu',
  port             => '80',
  docroot	   => '/home/Sync-UPR/master/public',
  directories      => [ {
    path    => '/home/Sync-UPR/master/public/',
    options => ['Indexes','FollowSymLinks','MultiViews'],
    directoryindex => ['index.php','index.html'],
    },],

  # redirect_status  => 'permanent',
  #redirect_dest    => 'https://sync.upr.edu.cu/',
 }


}

