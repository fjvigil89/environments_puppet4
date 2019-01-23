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

  class {'::haproxy_serv':
    enable_ssl        => false,
    stats             => true,
    ipaddress         => $ipaddress,
    listening_service => 'media',
    mode              => 'http',
    balancer_member   => ['media0','media1','media2'],
    server_names      => ['media0.upr.edu.cu','media1.upr.edu.cu','media2.upr.edu.cu'],
    ipaddresses       => ['10.2.24.3','10.2.24.4','10.2.24.5'],
    ports             => ['80'],
    frontend_name     => ['media_server'],
    frontend_options  => {
      'default_backend' => 'media_backend' ,
      'timeout client'  => '30s' ,
      'option'          => [
        'tcplog',
      ],
      },
    backend_names     => ['media_backend'],
    backend_options   => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
    bind              => {
      '0.0.0.0:80'  => [],
    },
  }
  haproxy::frontend { 'media_http':
    mode    => $frontend_mode,
    options => {
      'default_backend' => 'media_bhttp' ,
      'timeout client'  => '30s' ,
      'option'          => [
        'tcplog',
      ],
    },
    bind    => {
      '0.0.0.0:80'  => [],
    },
  }
  haproxy::backend { 'media_bhttp':
    mode    => 'http',
    options => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
  }
  haproxy::balancermember { 'media0.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media0.upr.edu.cu',
    ipaddresses       => '10.2.24.3',
    ports             => '80',
  }
  haproxy::balancermember { 'media1.upr.edu.cu':
    listening_service => 'media_bhttp',
    server_names      => 'media1.upr.edu.cu',
    ipaddresses       => '10.2.24.3',
    ports             => '80',
  }
 haproxy::balancermember { 'media2.upr.edu.cu':
   listening_service => 'media_bhttp',
   server_names      => 'media2.upr.edu.cu',
   ipaddresses       => '10.2.24.3',
   ports             => '80',
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
  group   => 'root',
  owner   => 'root',
  mode    => '0775',
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
  packages       => ['php7.0-dev','php7.0-apcu','php7.0-mbstring','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','php7.0-xml','php7.0-mysql','php7.0-common'],
}~>
apache::vhost { 'media0.upr.edu.cu':
   servername    => 'media0.upr.edu.cu',    
   serveraliases => ['www.media0.upr.edu.cu'],
   port          => '80',
   docroot       => '/opt/html/',
}~>
file{'/etc/apache2/sites-available/25-media.upr.edu.cu.conf':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "
# ************************************
# Vhost template in module puppetlabs-apache
# Managed by Puppet
# ************************************

<VirtualHost *:80>
  ServerName ${fqdn}

  ## Vhost docroot
  DocumentRoot '/opt/html/'

  ## Directories, there should at least be a declaration for /opt/html/

  <Directory '/opt/html'>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
    DirectoryIndex index.php

        <IfModule mod_rewrite.c>
                    Options -MultiViews
                    RewriteEngine On
                    RewriteCond %{REQUEST_FILENAME} !-f
                    RewriteRule ^(.*)$ index.php [QSA,L]
                </IfModule>

  </Directory>

  ## Logging
  ErrorLog '/var/log/apache2/media.upr.edu.cu_error.log'
  ServerSignature Off
  CustomLog '/var/log/apache2/media.upr.edu.cu_access.log' combined



  ## Server aliases
  ServerAlias www.${fqdn}
</VirtualHost>

  ",
  before  => Exec['a2enmod_php7'],
  notify  => Exec['service_apache2_restart'];
}

exec{"a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}~>
exec{"service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}

}

