###################
# Configure ftpbacken_server

class  ftpbackend_server {
class { '::basesys':
  uprinfo_usage   => 'Servidor HA FTP Backend',
  application     => 'Apache2',
  repos_enabled   => true,
  mta_enabled     => false,
}
include git

#Copy SSH Key
file { '/root/.ssh/id_rsa':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0600',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/id_rsa',
}

file { '/root/.ssh/id_rsa.pub':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/id_rsa.pub',
}

file { '/root/.ssh/config':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/config',
}
include git
vcsrepo { '/srv/ftp':
  ensure   => latest,
  provider => 'git',
  remote   => 'origin',
  source   => {
    'origin' => 'git@gitlab.upr.edu.cu:dcenter/ftp.git',
  },
  revision => 'master',
}
class { '::php::globals':
  php_version => '7.0',
}
class { '::php':
  ensure       => latest,
  manage_repos => false,
  fpm          => true,
  composer     => true,
  pear         => true,
}
ensure_packages(['php7.0-dev','php7.0-apcu','php7.0-mbstring','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-sybase','php7.0-mcrypt',
'libapache2-mod-php7.0','php7.0-xml','php7.0-mysql','php7.0-common','php-fpm','php7.0-gd','ffmpeg','graphicsmagick'])
class { 'apache':
  default_vhost => false,
  mpm_module    => 'prefork',
}
apache::vhost { $fqdn:
  servername    => $fqdn,
  serveraliases => ["www.${fqdn}"],
  port          => '80',
  docroot       => '/srv/ftp',
  suphp_engine     => 'off',
  directories   => [ {
    'path'           => '/srv/ftp',
    'options'        => ['Indexes','FollowSymLinks','MultiViews'],
    'allow_override' => 'All',
    'directoryindex' => '/_h5ai/public/index.php',
    },],
    }
    file_line { 'mod_rewrite':
      path   => "/etc/apache2/sites-available/25-${fqdn}.conf",
  line   => "\n
        <IfModule mod_rewrite.c>
            Options -MultiViews
            RewriteEngine On
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteRule ^(.*)$ index.php [QSA,L]
        </IfModule>
  \n",
  after  => "DirectoryIndex index.php",
}~>
exec { "a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}~>
exec { "service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}
}
#class { '::php::globals':
#  php_version   => '7.0',
#}~>
#class { '::php':
#  manage_repos  => false,
#  fpm           => true,
#  fpm_user      => 'www-data',
#  fpm_group     => 'www-data',
#  composer      => true,
#  pear          => true,
#}
#ensure_packages(['php-fpm','php7.0-gd','ffmpeg','graphicsmagick'])
#class { 'nginx':
#  manage_repo   => false,
#}
#nginx::resource::server { $fqdn:
#  listen_port   => 80,
#  www_root      => '/srv/ftp/',
#  index_files   => ['/_h5ai/public/index.php'],
#  access_log    => "/var/log/nginx/$fqdn-access.log",
#  error_log     => "/var/log/nginx/$fqdn-error.log", 
# }
# nginx::resource::location { '~ \.php$':
#   ensure       => present,
#   server       => $fqdn,
#   location     => '~\.php$',
#   index_files  => ['/_h5ai/public/index.php'],
#   fastcgi      => '127.0.0.1:9001',
# }
# php::fpm::pool{ 'ftp.conf':
#   user         => 'www-data',
#   group        => 'www-data',
#   listen_owner => 'www-data',
#   listen_group => 'www-data',
#   listen_mode  => '0660',
#   listen       => "127.0.0.1:9001",
# }
# file_line { 'fastcgi_param':
#  path          => "/etc/nginx/sites-available/${fqdn}.conf",
#  line          => "\n
#       fastcgi_index index.php;
#       fastcgi_send_timeout 5m;
#       fastcgi_read_timeout 5m;
#       fastcgi_connect_timeout 5m;
#  \n",
#  after         => "fastcgi_pass  127.0.0.1:9001;",
#}
#$line = "fastcgi_param    SCRIPT_FILENAME /srv/ftp/$"
#$line2 = "fastcgi_script_name;"
#$linef = "${line}${line2}"
#file_line { 'fastcgi_param1':
#  path          => "/etc/nginx/sites-available/${fqdn}.conf",
#  line          => $linef,
#  after         => "fastcgi_connect_timeout 5m;",
#}

#}

