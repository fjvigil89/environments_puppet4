 # == Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache::apache{

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

}
