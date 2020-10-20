define phpmyadmin_local::uninstall
{
	# Removing phpMyAdmin install dir
	exec {"rm -Rf ${phpmyadmin_local::params::instdir}": path => '/bin'}

	# Removing the source
	exec {"rm -Rf ${phpmyadmin_local::params::srcdir}/phpMyAdmin-*": path => '/bin'}
}
