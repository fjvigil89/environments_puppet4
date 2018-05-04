#
# Class monitoring::nginx
#==================================
#
# Configure nginx for icingaweb2

$vhost = 'puppet-icingaweb2'

include ::nginx

nginx::resource::server { 'icingaweb2':
 server_name          => [$vhost],
 ssl                  => true,
 ssl_cert             => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
 ssl_key              => '/etc/ssl/private/ssl-cert-snakeoil.key',
 ssl_redirect         => true,
 index_files          => [],
 use_default_location => false,
}

nginx::resource::location { 'root':
 location            => '/',
 server              => 'icingaweb2',
 index_files         => [],
 location_cfg_append => {
 rewrite =>  '^/(.*) https://$host/icingaweb2/$1 permanent'
 }
}

nginx::resource::location { 'icingaweb2_index':
 location       => '~ ^/icingaweb2/index\.php(.*)$',
 server         => 'icingaweb2',
 ssl            => true,
 ssl_only       => true,
 index_files    => [],
 fastcgi        => '127.0.0.1:9000',
 fastcgi_index  => 'index.php',
 fastcgi_script => '/usr/share/icingaweb2/public/index.php',
 fastcgi_param  => {
                    'ICINGAWEB_CONFIGDIR' =>  '/etc/icingaweb2',
                    'REMOTE_USER'         =>  '$remote_user',
 },
}

nginx::resource::location { 'icingaweb':
 location       => '~ ^/icingaweb2(.+)?',
 location_alias => '/usr/share/icingaweb2/public',
 try_files      => ['$1', '$uri', '$uri/', '/icingaweb2/index.php$is_args$args'],
 index_files    => ['index.php'],
 server         => 'icingaweb2',
 ssl            => true,
 ssl_only       => true,
}

include ::phpfpm

phpfpm::pool { 'main': }
