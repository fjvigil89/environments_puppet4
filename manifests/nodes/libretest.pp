node 'libretest.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage  => 'servidor librenms',
    application    => 'LibreNMS',
    puppet_enabled => true,
    repos_enabled  => false,
    mta_enabled    => false,
  }
  class { '::librenms':
    admin_email    => 'upredes@upr.edu.cu',
    php_timezone   => 'America/Havana',
    admin_pass     => 'admin',
    db_pass        => 'librenms',
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
 class { 'snmpd':
  package       => true,
  service       => true,
  allowed_hosts => ['10.2.0.0/21'],
  community     => 'UPRadmin4all',
  syslocation   => 'Datacenter, UPR',
  syscontact    => 'upredes@upr.edu.cu'
}
 class { '::librenms::device':
   proto      => 'v2',
   community  => 'UPRadmin4all',
 }
}
