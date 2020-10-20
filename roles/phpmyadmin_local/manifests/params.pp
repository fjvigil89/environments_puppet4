class phpmyadmin_local::params
{
	$ensure         = "present"
  $php_version    = "7.3"
	$version        = "3.5.8.1"
	$srcdir         = "/usr/src"
	$instdir        = "/usr/share/phpMyAdmin"
	$vhost_name     = "phpmyadmin.local"
	$vhost_port     = "80"
	$vhost_priority = "99"
	$root_password  = "root"
}
