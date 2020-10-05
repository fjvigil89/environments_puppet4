node 'libretest.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor librenms',
    application    => 'LibreNMS',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
  include librenmserver
#  class { '::php':
#    config_overrides => { date.timezone => 'America/Havana' },
#}
 class { '::librenms':
  admin_pass     => 'admin',
  db_pass        => 'librenms',
  poller_modules => { 'os'             => 1,
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
 class { '::librenms::dbserver':
   bind_address   => '127.0.0.1',
   password       => 'librenmsdb',
   root_password  => 'libredb',
}
 class { '::snmpd':
   iface              => 'eth0@if32',
   allow_address_ipv4 => '10.2.0.0',
   allow_netmask_ipv4 => '21',
   #users              => { 'monitor' => { 'pass' => 'my-password' } },
 }
 class { '::librenms::device':
   proto      => 'v2',
   community  => 'UPRadmin4all',
 }
}
