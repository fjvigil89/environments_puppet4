define phpmyadmin_local::install($version = $title, $installdir)
{
	# Params
	$pkgname     = "phpMyAdmin-${version}-all-languages.tar.bz2"
	$urlsource   = "https://files.phpmyadmin.net/phpMyAdmin/${version}/phpMyAdmin-${version}-all-languages.tar.gz" 
	$destination = "${phpmyadmin_local::params::srcdir}/${pkgname}"
	# Params

	# Creating source directory
	if !defined(File[$phpmyadmin_local::params::srcdir]) {
		file {$phpmyadmin_local::params::srcdir :
			ensure => directory,
			owner  => 'root',
			group  => 'root',
			mode   => '0755',
		}
	}
	# Creating source directory

	# Downloading the package
	wget::fetch {'wget-phpmyadmin':
		source      => $urlsource,
		destination => $destination,
		before      => Exec['tar-phpmyadmin'],
	}
	# Downloading the package

	# Unpacking the source
	exec {'tar-phpmyadmin':
		command => "tar -jxf ${destination}",
		path    => ['/bin','/usr/bin'],
		cwd     => $phpmyadmin_local::params::srcdir,
		onlyif  => [
			"test -f ${destination}",
			"test ! -d ${phpmyadmin_local::params::srcdir}/phpMyAdmin-${version}-all-languages",
		],
		before  => Exec['copy-phpmyadmin'],
	}
	# Unpacking the source

	# Installing the phpMyAdmin
	file {$phpmyadmin_local::params::instdir:
		ensure => directory,
		owner  => 'root',
		group  => 'root',
		mode   => '0755',
	}
	exec {'copy-phpmyadmin':
		command => "cp -Rf ${phpmyadmin_local::params::srcdir}/phpMyAdmin-${version}-all-languages ${phpmyadmin_local::params::instdir}/${version}",
		path    => ['/bin','/usr/bin'],
		onlyif  => [
			"test -d ${phpmyadmin_local::params::srcdir}/phpMyAdmin-${version}-all-languages",
			"test ! -d ${phpmyadmin_local::params::instdir}/${version}",
		],
		require => File[$phpmyadmin_local::params::instdir],
	}
	file {"${phpmyadmin_local::params::instdir}/current":
		ensure => link,
		target => "${phpmyadmin_local::params::instdir}/${version}",
	}
	# Installing the phpMyAdmin
}
