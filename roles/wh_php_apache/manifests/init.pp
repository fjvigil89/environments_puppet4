#== Class: wh_php_apache
#
# Full description of class wh_php_apache here.
#
class wh_php_apache(
  Optional[String] $version = '7.0',
  Optional[Array[String]] $packages = undef,
) {
  #class {'::filebeatserver':
  #  paths    => '/var/log/apache2/*.log',
  #  log_type => "apache",
  # }

  
 include git
 include vim
 #class {'::wh_php_apache::apache':;}

class { ::letsencrypt:
  unsafe_registration => true,
}

if !defined(${packages})
{
  $packages = ["php${version}","php${version}-mbstring","php${version}-cli","php${version}-curl","php${version}-intl","php${version}-ldap","php${version}-mysql","php${version}-sybase","libapache2-mod-php${version}","php${version}-mcrypt",'freetds-bin','freetds-common']
}

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
     packages       =>  $packages,
 }

 





}
