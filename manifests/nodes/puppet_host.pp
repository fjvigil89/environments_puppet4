node 'client-puppet.upr.edu.cu'{
  #class {'::talkserver':;}
  class { '::basesys':  
    uprinfo_usage => 'servidor test',
    application   => 'puppet',  
    # repos_enabled => false,      
  }
  #class { '::letsencrypt_host':
  #email => 'fjvigil@hispavista.com',
  #webroot_enable => true,
  #dominios => ['sync.upr.edu.cu'],
  #plugin => 'webroot',
  #webroot_paths => ['/root/Sync-UPR/public/'],
  #}
  #include dns_primary
  #include puppetdevserver
  #include puppetprodserver

  #class { 'openldap::server':
  #}
  #openldap::server::globalconf { 'security':
  #  ensure => present,
  #  #value  => 'tls=128',
  #}
  #openldap::server::module { 'syncprov':
  #  ensure => present,
  #}
  #openldap::server::overlay { 'syncprov on dc=upr,dc=edu,dc=cu':
  #  ensure => present,
  #}


  class { 'squid_server':
    http_access                   => { 'Red_Universitaria' => { action => 'allow', value =>'UPR', }},
    http_ports                    => { 'http' => { port => '8080', }},
    https_ports                   => { 'https' => { port => '8443',}},
    icp_access                    => { 'icp_access'=>{ action => 'deny', value =>'all',}},
    icp_port                      => { 'icp_port'=>{ port =>'0', }},
    cache_mem                     => '2048',
    maximum_object_size_in_memory => '1024',
    memory_replacement_policy     => 'heap GDSF',
    cache_replacement_policy      => 'heap LFUDA',
    maximum_object_size_in_memory => '4',
  }
  squidserver::acl { 'CONNECT':
    type    => method,
    entries => ['CONNECT'],
  }
  squidserver::acl { 'Safe_ports':
    type    => port,
    entries => ['80','443','21','70','210','1025-65535','280','488','591','777'],
  }
  squidserver::acl { 'UPR':
    type    => src,
    entries => ['10.2.0.0/15'],

  }
  
  squidserver::tcp_outgoing_address{'OutGoing':
    value    => ['200.14.49.29','200.55.143.8','152.207.173.41'],
    acl_name => ['UPR','UPR','UPR']
  }

  squidserver::cache_peer{'cache_peer':
    pattern    => ['127.0.0.1','proxy-tor.upr.edu.cu'],
    type       => ['parent','parent'],
    proxy_port => ['8443','8080'],
    icp_port   => ['0','0'],
    options    => ['no-query','proxy-only'],
  }

}


node 'puppet-test.upr.edu.cu'{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
    #proxmox_enabled => false,
  }
  #class {'::serv_logrotate':
  # compress         => true, 
  #  filelog_numbers  => [5,7],
  #  rotate_frecuency => ['week'],
  #  rule_list        => ['messages', 'apache'],
  #  log_path         => ['/var/log/messages', '/var/log/apache2/*.log'],
  #}
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
    packages       => ['php7.0-ldap','php7.0-mysql'],
  }
  file { '/usr/share/ad-to-pap.php':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0774',
    source => 'puppet:///modules/freeradius_server/sync/ad-to-pap.php',
  }

  class { 'freeradius':
    max_requests    => 1024,
    max_servers     => 1024,
    mysql_support   => true,
    utils_support   => true,
    syslog          => true,
    log_auth        => 'yes',
  }
  package { 'freeradius-ldap':
    ensure => installed,
  }
  class { 'freeradius::status_server':
    port   => '18120',
  }
  include '::mysql::server'
  mysql::db { 'radius':
    user     => 'radius',
    password => 'freeradius.upr2k18',
    host     => 'localhost',
    grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
    #sql      => '/etc/freeradius/3.0/mods-config/sql/main/mysql/schema.sql',
  }

  freeradius::sql { 'radius':
    database  => 'mysql',
    server    => 'localhost',
    login     => 'radius',
    password  => 'freeradius.upr2k18',
    radius_db => 'radius',
  }
  freeradius::listen { 'pap-auth':
    type      => 'auth',
    ip        => '*',
    interface => 'eth0',
  }
  freeradius::listen { 'pap-acct':
    type      => 'acct',
    ip        => '*',
    interface => 'eth0',
  }
  freeradius::client { 'ras-pap':
    ip              => '192.168.25.0/24',
    secret          => 'upradius2k9',
    shortname       => 'ras-pap',
    nastype         => 'other',
    port            => '1645-1646',
    firewall        => true,
    max_connections => 0,
  }
  freeradius::module::ldap { 'ad-pap':
    server                => '10.2.24.35',
    port                  => 389,
    basedn                => 'DC=upr,DC=edu,DC=cu',
    identity              => 'ras@upr.edu.cu',
    password              => 'freeradius.upr2k18',
    user_filter           => "(&(memberOf=cn=UPR-Ras,ou=_Gestion,dc=upr,dc=edu,dc=cu)(samAccountName=%{%{Stripped-User-Name}:-%{User-Name}})(objectclass=person))",
    timeout               => 20,
    group_filter          => "(objectclass=radiusprofile)",
  }
  freeradius::blank { ['eap.conf',]:}
  freeradius::home_server { 'localhost':
    secret => 'testing123',
    type   => 'auth',
    ipaddr => '127.0.0.1',
    port   => 1812,
    proto  => 'udp',
  }
  #freeradius::home_server_pool { 'auth_failover':
  #  home_server => 'localhost',
  #  type        => 'fail-over',
  #}
  freeradius::realm { 'pap.upr.edu.cu':
    acct_pool => 'localhost',
  }
  #freeradius::module::eap { 'eap':
  #  default_eap_type      => 'md5',
  #  gtc_auth_type         => 'PAP',
  #  eap_peap              => true,
  #  eap_gtc               => true,
  #  ttls_default_eap_type => 'md5',
  #  peap_virtual_server   => 'inner-tunnel',
  #}
  #include freeradius_server 
  #class {'::firewallprod':
   #  hosts_todrop   => ['111.111.111.111', '50.138.112.159', '31.220.16.147'],
   #  hosts_toaccept => ['200.55.143.160/29','200.55.153.64/28'],
   #  chain_from     => 'from-reduniv',
   #  chain_to       => 'to-reduniv',
   #  open_ports     => [8080,443,53,22],
   #}

  }

node 'puppet-henry.upr.edu.cu'{
  include smokeprodserver
  class {'smokeserver':
    target           => ['Routers','L3','PAP','FCP','FCF','CUM','Vinales','Palacios','San_Luis','Minas','Guane','Mantua','La_Palma','Sandino','Consolacion'],
    menu             => ['Routers','Switch L3 Nodo Central','Router PAP','Router FCP','Router FCF','CUM','Viñales','Los Palacios','San Luis','Minas','Guane','Mantua','La Palma','Sandino','Consolacion'],
    hierarchy_level  => [1,2,2,2,2,1,2,2,2,2,2,2,2,2,2],
    hierarchy_parent => ['Routers','Routers','Routers','Routers','Routers','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM'],
    host             => ['','10.2.1.1','10.2.1.5','10.2.0.10','10.2.8.200','','10.2.20.49','10.2.20.119','10.2.20.177','10.2.20.33','10.2.20.209','10.2.20.17','10.2.20.165','10.2.20.1','10.2.20.145'],
  }
}
  # class { 'prosody':
  #   user              => 'prosody',
  #    group             => 'prosody',
  #  community_modules => ['mod_auth_ldap'],
  #  authentication    => 'ldap',
  #  custom_options    => {
  #    'ldap_base'     => "'dc=upr','dc=edu','dc=cu'",
  #    'ldap_server'   => "'10.2.24.35:389'",
  #    'ldap_rootdn'   => "'CN=talk','OU=_Servicios','DC=upr','DC=edu','DC=cu'",
  #    'ldap_password' => "'40a*talk.2k12'",
  #    'ldap_scope'    => "subtree",
  #    'ldap_tls'      => 'true',
  #  },
  #}
  #prosody::virtualhost {
  #  'puppet-henry.upr.edu.cu' :
  #    ensure   => present,
  #    #ssl_key  => '/etc/ssl/key/puppet-henry.upr.edu.cu.key',
  #    #ssl_cert => '/etc/ssl/crt/puppet-henry.upr.edu.cu.cert',
  #}
  #prosody::user { 'admin':
  #  host => 'puppet-henry.upr.edu.cu',
  #  pass => 'admin',
  #}
  #}
