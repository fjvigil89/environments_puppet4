node 'ha-media.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor HAproxy Media',
    application     => 'HA proxy Media',
    repos_enabled   => true,
    mta_enabled     => false,
  }

  class { '::haproxy_serv':
    enable_ssl        => false,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'media',
    mode              => 'http',
    balancer_member   => ['media0','media1','media2'],
    server_names      => ['media0.upr.edu.cu','media1.upr.edu.cu','media2.upr.edu.cu'],
    ipaddresses       => ['10.2.4.41','10.2.4.42','10.2.4.43'],
    ports             => ['80'],
  }
  haproxy::listen { 'media_bhttp':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '80',
  }
  haproxy::balancermember { 'media0.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media0.upr.edu.cu',
    ipaddresses       => '10.2.4.41',
    ports             => '80',
  }
  haproxy::balancermember { 'media1.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media1.upr.edu.cu',
    ipaddresses       => '10.2.4.42',
    ports             => '80',
  }
  haproxy::balancermember { 'media2.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media2.upr.edu.cu',
    ipaddresses       => '10.2.4.43',
    ports             => '80',
  }
##Samba config to permit user to upload media
class { 'samba::server':
  workgroup     => 'WORKGROUP',
  server_string => "Media Samba Server",
  interfaces    => "eth0 lo",
  security      => 'user'
}
samba::server::share { 'media':
  comment              => 'Media',
  path                 => '/srv/media',
  browsable            => true,
  writable             => true,
  valid_users          => "yosbel",
  directory_mask       => 0777,
}
user { "yosbel":
  ensure   => present,
}
}

node /^media\d+$/ {
class { '::basesys':
  uprinfo_usage   => 'Servidor HA Media',
  application     => 'HA Media',
  repos_enabled   => true,
  mta_enabled     => false,
}
#include apache
include git

file { '/opt/html':
  ensure  => directory,
  group   => 'users',
  owner   => 'root',
  mode    => '0777',
  }~>
vcsrepo { '/opt/html':
  ensure   => latest,
  provider => 'git',
  remote   => 'origin',
  source   => {
    'origin' => 'git@gitlab.upr.edu.cu:dcenter/media.git',
  },
  revision => 'master',
}


class { '::php_webserver':
  php_version    => '7.0',
  php_extensions => {
    'curl'     => {},
    'gd'       => {},
    'mysql'    => {},
    'ldap'     => {},
    'xml'      => {},
    'mbstring' => {},
  },
  packages       => ['php7.0-dev','php7.0-apcu','php7.0-mbstring','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-sybase',
  'libapache2-mod-php7.0','php7.0-mcrypt','php7.0-xml','php7.0-mysql','php7.0-common','php-fpm','php7.0-gd','ffmpeg','graphicsmagick'],
}~>
apache::vhost { $fqdn:
   servername    => $fqdn,    
   serveraliases => ["www.${fqdn}"],
   port          => '80',
   docroot       => '/srv/media',
   directories   => [ {
     'path'           => '/srv/media',
     'options'        => ['Indexes','FollowSymLinks','MultiViews'],
     'allow_override' => 'All',
     'directoryindex' => '/_h5ai/public/index.php',
     },],
 }~>
 #file_line { 'mod_rewrite':
 # path   => "/etc/apache2/sites-available/25-${fqdn}.conf",
 # line   => "\n
 #    <IfModule mod_rewrite.c>
 #            Options -MultiViews
 #            RewriteEngine On
 #            RewriteCond %{REQUEST_FILENAME} !-f
 #            RewriteRule ^(.*)$ index.php [QSA,L]
 #     </IfModule>
 # \n\n",
 #after  => "DirectoryIndex /_h5ai/public/index.php",

 #}~>
exec { "a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}~>
exec { "service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}



}

