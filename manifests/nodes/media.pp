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
    ipaddress         => $ipaddress,
    listening_service => 'media',
    mode              => 'http',
    balancer_member   => ['media0','media1','media2'],
    server_names      => ['media0.upr.edu.cu','media1.upr.edu.cu','media2.upr.edu.cu'],
    ipaddresses       => ['10.2.24.3','10.2.24.4','10.2.24.5'],
    ports             => ['80'],
    frontend_name     => 'media_server',
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
  packages       => ['php7.0-dev','php7.0-apcu','php7.0-mbstring','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt'],
}

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

apache::vhost { 'media0.upr.edu.cu':
  servername    => 'media0.upr.edu.cu',    
  serveraliases => ['www.media0.upr.edu.cu'],
  port          => '80',
  docroot       => '/opt/html/',
  directories   => [ {
    'path'           => '/opt/html',
    'options'        => ['Indexes','FollowSymLinks','MultiViews'],
    'allow_override' => 'All',
    'directoryindex' => 'index.php',
    },],
    
}


exec{"a2enmod_php7":
  command => '/usr/bin/sudo a2enmod php7.0',
}

exec{"service_apache2_restart":
  command     => '/usr/bin/sudo service apache2 restart',
  refreshonly => true;
}


}

