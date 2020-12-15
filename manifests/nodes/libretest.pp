node 'libretest.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor librenms',
    application    => 'LibreNMS',
    puppet_enabled => true,
    repos_enabled  => false,
    mta_enabled    => false,
    dmz            => true,
  }
  class { '::librenms':
    version        => $::librenms_version,
    manage_php     => true,
    manage_apache  => true,
    ssl            => true,
    admin_email    => 'upredes@upr.edu.cu',
    php_timezone   => 'America/Havana',
    admin_pass     => 'adminpass',
    server_name    => $::fqdn,
    db_pass        => 'librenmsdb',
    poller_modules => { 'os'           => 1,
                      'processors'     => 1,
                      'mempools'       => 1,
                      'storage'        => 1,
                      'netstats'       => 1,
                      'hr-mib'         => 1,
                      'ucd-mib'        => 1,
                      'ipSystemStats'  => 1,
                      'ports'          => 1,
                      'ucd-diskio'     => 1,
                      'entity-physical'=> 1,
                    },
}
 class { '::librenms::device':
   proto      => 'v2c',
   community  => 'UPRadmin4all',
 }
 class { '::mysql::server':
  root_password           => 'libre',
  restart                 => true,
  override_options        => $override_options,
  before                  => Class['::librenms::config'],
  #remove_default_accounts => false,
}
::mysql::db { 'librenms':
  user     => 'librenms',
  password => $::db_pass,
  host     => 'localhost',
  grant    => ['ALL'],
  charset  => 'utf8',
  collate  => 'utf8_unicode_ci',
  before   => Class['::librenms::config'],
  require  => Class['::mysql::server'],
#  #grant    =>  ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER', 'REFERENCES'],
  }
}
