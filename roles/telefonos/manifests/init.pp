# Class: php_server
# ===========================
#
# Full description of class telefono here.

  class telefonos(
    Boolean $manage_repos     = false,
    String  $version          = $::telefonos::params::version,
    Array[String] $packages   = $::telefonos::params::pachages,
    )inherits ::telefonos::params {
    
  include git
  include vim
    
  class { '::php_webserver':
    php_version    => $version,
    php_extensions => {
      'curl'     => {},
      'gd'       => {},
      'mysql'    => {},
      'ldap'     => {},
      'xml'      => {},
      'mbstring' => {},
      },
    manage_repos   => $manage_repos,
    packages       => $packages,
    }

file { '/var/www/telefonos':
  ensure => directory,
  group  => 'root',
  owner  => 'root',
  mode   => '0775',
  }~>
  vcsrepo { '/var/www/telefonos':
    ensure     => latest,
	provider   => 'git',
	remote     => 'origin',
	source     => {
	    'origin' => 'git@gitlab.upr.edu.cu:dcenter/telefonos.git',
		},
	revision   => 'master',
	}
	
 apache::vhost { 'telefonos':
   port       => '80',
   docroot    => '/var/www/telefonos/',
   servername => 'telefonos-pup.upr.edu.cu',
   aliases    => 'telefonos',
   }

 #Copy SSH Key
 #
# file { '/root/.ssh/id_rsa':
#   ensure => file,
#   owner  => 'root',
#   group  => 'root',
#   mode   => '0600',
#     source => 'puppet:///modules/telefonos/keys/id_rsa',
#	 }
# file { '/root/.ssh/id_rsa.pub':
#   ensure => file,
#   owner  => 'root',
#   group  => 'root',
#   mode   => '0644',
#     source => 'puppet:///modules/telefonos/keys/id_rsa.pub',
#	 }
# file { '/root/.ssh/config':
#   ensure => file,
#   owner  => 'root',
#   group  => 'root',
#   mode   => '0644',
#   source => 'puppet:///modules/telefonos/keys/config',
#   }
   }
