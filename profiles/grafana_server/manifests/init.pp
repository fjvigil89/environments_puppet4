# == Class: grafana_server
#
# Full description of class grafana_server here.
#
# === Parameters
#
class grafana_server {
class { '::mysql::server':
 root_password           => 'graphite.2k18',
 remove_default_accounts => true,
} 
mysql::db { 'grafana':
user     => 'grafana',
password => 'grafana*upr.2k18',
host     => 'localhost',
grant    =>  ['ALL'],
}
class { 'grafana':
cfg => {
app_mode => 'production',
server   => {
      http_port     => 8080,
    },
    database => {
      type          => 'mysql',
      host          => '127.0.0.1:3306',
      name          => 'grafana',
      user          => 'grafana',
      password      => 'grafana*upr.2k18',
    },
    users    => {
      allow_sign_up => false,
    },
  },
ldap_cfg   => {
   servers => [
    { host            => 'ad.upr.edu.cu',
      port            => 389,
      use_ssl         => false,
      search_filter   => '(sAMAccountName=%s)',
      search_base_dns => [ 'ou=_GrupoRedes,dc=upr,dc=edu,dc=cu' ],
      bind_dn         => 'icinga2',
      bind_password   => 'web.2k17',
    },
  ],
  'servers.attributes' => {
    name      => 'givenName',
    surname   => 'sn',
    username  => 'sAMAccountName',
    member_of => 'memberOf',
    email     => 'email',
  }
},
grafana_organization { 'UPRedes':
  grafana_url      => 'http://localhost:3000',
  grafana_user     => 'admin',
  grafana_password => 'grafana',
}
grafana_dashboard { 'example_dashboard':
  grafana_url       => 'http://localhost:3000',
  grafana_user      => 'admin',
  grafana_password  => 'grafana',
  grafana_api_path  => '/grafana/api',
  organization      => 'UPRedes',
  content           => template('path/to/exported/file.json'),
}
}

}
