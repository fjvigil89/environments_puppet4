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

#Script to update antivirus, crontab
file { '/srv/update.sh':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0774',
  source => 'puppet:///modules/ftpbackend_server/update_antiv/update.sh',
}
cron { 'update_antivirus':
 ensure  => 'absent',
 command => '/srv/update.sh',
 user    => 'root',
 hour    => '5',
 minute  => 'absent',
}


vcsrepo { '/srv/ftp':
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
  packages       => ['php-fpm','php7.0-gd','ffmpeg','graphicsmagick'],
}~>
nginx::resource::server { $fqdn:
  ensure      => present,
  server_name => $fqdn,    
  listen_port => '80',
  www_root    => '/srv/ftp',
  access_log  => "/var/log/nginx/$fqdn-access.log",
  error_log   => "/var/log/nginx/$fqdn-error.log", 
 }
 nginx::resource::location { '~ \.php$':
   ensure                  => present,
   vhost                   => $fqdn,
   fastcgi                 => 'unix:/var/run/php/php7.0-fpm.sock',
   fastfgi_index           => 'index.php',
   fastcgi_send_timeout    => '5m',
   fastcg_read_time_out    => '5m',
   fastcgi_connect_timeout => '5m',
   fast_param              => 'SCRIPT_FILENAME /srv/ftp/$fastcgi_script_name',
 }
}

