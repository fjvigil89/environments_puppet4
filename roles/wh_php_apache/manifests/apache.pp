 # == Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache::apache{

 class { 'apache':
  default_vhost => true,
 }

}
