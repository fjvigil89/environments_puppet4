class phpmyadmin_local::secure
{
	define install($package = $title)
	{
		if !defined(Package[$package]) {
			package {$package: ensure => present}
		}
	}
}
