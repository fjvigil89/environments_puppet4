# Class: php_server
# ===========================
#
# Full description of class php_server here.
class php_server(
  Boolean $manage_repos     = false,
  String  $version          = $::php_server::params::verion,
  Array[String] $packages   = $::php_server::params::pachages,
)inherits ::php_server::params {

 class { '::basesys':
    uprinfo_usage => 'servidor phpipam',
    application   => 'phpipam',
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
}
