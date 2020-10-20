# Class: phpmyadmin_local
# ===========================
#
# Full description of class phpmyadmin_local here.
#
# Copyright 2020 Your name here, unless otherwise noted.
#
class phpmyadmin_local (
  $ensure         = $phpmyadmin_local::params::ensure,
  $version        = $phpmyadmin_local::params::version,
  $php_version    = $phpmyadmin_local::params::php_version,
  $installdir     = $phpmyadmin_local::params::instdir,
  $vhost_name     = $phpmyadmin_local::params::vhost_name,
  $vhost_port     = $phpmyadmin_local::params::vhost_port,
  $vhost_priority = $phpmyadmin_local::params::vhost_priority,
  $root_password  = $phpmyadmin_local::params::root_password,
){

  include phpmyadmin_local::dependencies
  case $ensure {
		present: {
			phpmyadmin_local::install {$version:
				installdir => $installdir,
			}
			if !defined(Class['mysql::server']) {
				class {'mysql::server':
					root_password => $root_password,
				}
			}
			if !defined(Class['apache']) {
				class {'apache':
					default_mods  => true,
					default_vhost => false,
					mpm_module    => 'prefork',
				}
				apache::mod {"${php_version}":}
			}
			apache::vhost {$vhost_name:
				priority => $vhost_priority,
				port     => $vhost_port,
				docroot  => "${installdir}/current",
			}
		}
		absent : { phpmyadmin_local::uninstall {'uninstall':} }
		default: { fail("Unsupported option for \"ensure\" param: ${ensure}") }

}
}
