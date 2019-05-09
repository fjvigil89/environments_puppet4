# Class: php_server
# ===========================
#
# Full description of class php_server here.

  class telefonos(
    Boolean $manage_repos     = false,
    String  $version          = $::telefonos::params::version,
    Array[String] $packages   = $::telefonos::params::pachages,
    )inherits ::telefonos::params {
    
  class { '::basesys':
      uprinfo_usage => 'servidor telefonos',
      application   => 'guia de telefonos UPR',
      mta_enabled   => false,
      repos_enabled => false,
      }
    
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
    vcsrepo { '/home/telefonos/':
      ensure   => latest,
      provider => 'git',
      remote   => 'origin',
      source   => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/telefonos.git,
	},
      revision => 'master',
      }
      }
