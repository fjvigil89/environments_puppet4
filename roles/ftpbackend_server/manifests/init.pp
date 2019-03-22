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
  mode   => '0755',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/id_rsa',
}

file { '/root/.ssh/id_rsa.pub':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
  source => 'puppet:///modules/ftpbackend_server/ssh_keys/id_rsa.pub',
}


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
 file_line { 'mod_rewrite':
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
exec { "a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}~>
exec { "service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}
}

