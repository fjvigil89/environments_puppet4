node 'ha-ftp.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'Servidor HAproxy FTP',
    application     => 'HAproxy FTP',
    repos_enabled   => true,
    mta_enabled     => false,
  }

  class {'::haproxy_serv':
    enable_ssl        => false,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'ftp',
    mode              => 'http',
    balancer_member   => ['ftp0','ftp1','ftp2'],
    server_names      => ['ftp0.upr.edu.cu','ftp1.upr.edu.cu','ftp2.upr.edu.cu'],
    ipaddresses       => ['10.2.4.55','10.2.4.56','10.2.4.57'],
    ports             => ['80'],
  }
  haproxy::listen { 'ftp_bhttp':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '80',
  }
  haproxy::balancermember { 'ftp0.upr.edu.cu':
    listening_service => 'ftp_bhttp',
    server_names      => 'ftp0.upr.edu.cu',
    ipaddresses       => '10.2.4.55',
    ports             => '80',
  }
  haproxy::balancermember { 'ftp1.upr.edu.cu':
    listening_service => 'ftp_bhttp',
    server_names      => 'ftp1.upr.edu.cu',
    ipaddresses       => '10.2.4.56',
    ports             => '80',
  }
 haproxy::balancermember { 'ftp2.upr.edu.cu':
   listening_service => 'ftp_bhttp',
   server_names      => 'ftp2.upr.edu.cu',
   ipaddresses       => '10.2.4.57',
   ports             => '80',
 }
}
node /^ftp\d+$/ {
class { '::basesys':
  uprinfo_usage   => 'Servidor HA FTP Backend',
  application     => 'Apache2',
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
    'origin' => 'git@gitlab.upr.edu.cu:dcenter/ftp.git',
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
  packages       => ['php7.0-dev','php7.0-apcu','php7.0-mbstring','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','php7.0-xml','php7.0-mysql','php7.0-common'],
}~>
apache::vhost { $fqdn:
   servername    => $fqdn,    
   serveraliases => ["www.${fqdn}"],
   port          => '80',
   docroot       => '/opt/html/',
   directories   => [ {
     'path'           => '/opt/html',
     'options'        => ['Indexes','FollowSymLinks','MultiViews'],
     'allow_override' => 'All',
     'directoryindex' => 'index.php',
     },],
 }~>
file_line{ 'mod_rewrite':
  path   => "/etc/apache2/sites-available/25-${fqdn}.conf",
  # line => "DirectoryIndex index.php",
  line   => "\n
     <IfModule mod_rewrite.c>
             Options -MultiViews
             RewriteEngine On
             RewriteCond %{REQUEST_FILENAME} !-f
             RewriteRule ^(.*)$ index.php [QSA,L]
      </IfModule>
  \n\n",
  after  => "DirectoryIndex index.php",

}~>
exec{"a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}~>
exec{"service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}



}

