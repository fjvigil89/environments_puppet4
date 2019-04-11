node 'puppet-test1.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage   => 'servidor test',
    application     => 'puppet',
    enable_firewall => true,
  }
}
  #include squidserver
  #class { 'squid': }
  #  squid::acl { 'Safe_ports':
  #    type    => port,
  #    entries => ['80'],
  #  }
  #  squid::http_access { 'Safe_ports':
  #    action => allow,
  #  }
  #  squid::http_access { 'red_pap AccesoAlGrupo': 
  #    action => allow,
  #  }
  #  squid::http_access{ '!Safe_ports':
  #    action => deny,
  #  }
  #  squid::http_port { '8080':}
  #  squid::acl { 'red_pap':
  #    type    => src,
  #    entries => ['10.71.46.0/24 20.0.0.0/24 10.2.9.0/24 10.2.75.0/25'],
  #  }
  #  squid::extra_config_section { 'external_acl_type':
  #    config_entries => [{ 'external_acl_type' => ['ADGroup %LOGIN /usr/lib/squid3/ext_ldap_group_acl -R -v 3 -b "dc=upr,dc=edu,dc=cu" -D internet@upr.edu.cu -w P@ssword -f "(&(objectclass=person)(sAMAccountName=%v)(memberof=cn=%a,ou=_Gestion,dc=upr,dc=edu,dc=cu))" -h 10.2.24.35'],
  #    }],
  #  }
  #  squid::acl { 'AccesoAlGrupo':
  #    type    => external,
  #    entries => ['ADGroup UPR-Internet-Profes UPR-Internet-NoDocente UPR-Internet-Est'],
  #  }
  #  squid::auth_param { 'basic auth_param':
  #    scheme  => 'basic',
  #    entries => [
  #      'program /usr/lib/squid3/basic_ldap_auth -R -v 3 -b "dc=upr,dc=edu,dc=cu" -D internet@upr.edu.cu -w P@ssword -f (|(userPrincipalName=%s)(sAMAccountName=%s)) -h 10.2.24.35',
  #      'children 10',
  #      'realm Servidor Proxy de la UPR',
  #      'credentialsttl 2 hours',
  #    ],
  #  }
    #cache_mem               => '512',
    #workers                 => 3,
    #coredump_dir            => '/var/spool/squid',
    #acls                    => { 'red_pap' => {
    #                type    => 'src',
    #                entries => ['10.2.9.0/25',
    #                            '10.71.46.0/24',
    #                            '20.0.0.0/24',
    #                            '10.2.75.0/25',],
    #},
    #http_access             => {'red_pap' => {action => 'allow',}},
    #cache_dirs              => { '/data/' => { type => 'ufs', options => '15000 32 256 min-size=32769', process_number => 2 }},
    #}
node 'puppet-test.upr.edu.cu' {
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
  }
  class { '::php':
    config_overrides => { date.timezone => 'America/Havana' },
  }
  class { '::librenms':
    admin_pass     => 'librenms.2k19',
    db_pass        => 'dblibrenms.2k19',
    poller_modules => { 
      'os'              => 1,
      'processors'      => 1,
      'mempools'        => 1,
      'storage'         => 1,
      'netstats'        => 1,
      'hr-mib'          => 1,
      'ucd-mib'         => 1,
      'ipSystemStats'   => 1,
      'ports'           => 1,
      'ucd-diskio'      => 1,
      'entity-physical' => 1,
      'mib'             => 1,
      'tonner'          => 1,
    },
  }
  class { '::librenms::dbserver':
    bind_address   => '127.0.0.1',
    password       => 'dblibrenms.2k19',
    root_password  => 'librenms.2k19',
  }
}
  #class {'::serv_logrotate':
  # compress         => true,
  #  filelog_numbers  => [5,7],
  #  rotate_frecuency => ['week'],
  #  rule_list        => ['messages', 'apache'],
  #  log_path         => ['/var/log/messages', '/var/log/apache2/*.log'],
  #}
  #class { '::php_webserver':
  #  php_version    => '7.0',
  #  php_extensions => {
  #    'curl'     => {},
  #    'gd'       => {},
  #    'mysql'    => {},
  #    'ldap'     => {},
  #    'xml'      => {},
  #    'mbstring' => {},
  #  },
  #  packages       => ['php7.0-ldap','php7.0-mysql'],
  #}
  #file { '/usr/share/ad-to-pap.php':
  #  ensure => file,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0774',
  #  source => 'puppet:///modules/freeradius_server/sync/ad-to-pap.php',
  #}

  #class { 'freeradius':
  #  max_requests    => 1024,
  #  max_servers     => 1024,
  #  mysql_support   => true,
  #  utils_support   => true,
  #  syslog          => true,
  #  log_auth        => 'yes',
  #}
  #package { 'freeradius-ldap':
  #  ensure => installed,
  #}
  #class { 'freeradius::status_server':
  #  port   => '18120',
  #}
  #include '::mysql::server'
  #mysql::db { 'radius':
  #  user     => 'radius',
  #  password => 'freeradius.upr2k18',
  #  host     => 'localhost',
  #  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
    #sql      => '/etc/freeradius/3.0/mods-config/sql/main/mysql/schema.sql',
    #}

    #freeradius::sql { 'radius':
    #database  => 'mysql',
    #server    => 'localhost',
    #login     => 'radius',
    #password  => 'freeradius.upr2k18',
    #radius_db => 'radius',
    #}
    #freeradius::listen { 'pap-auth':
    #type      => 'auth',
    #ip        => '*',
    #interface => 'eth0',
    #}
    #freeradius::listen { 'pap-acct':
    #type      => 'acct',
    #ip        => '*',
    #interface => 'eth0',
    #}
    #freeradius::client { 'ras-pap':
    #ip              => '192.168.25.0/24',
    #secret          => 'upradius2k9',
    #shortname       => 'ras-pap',
    #nastype         => 'other',
    #port            => '1645-1646',
    #firewall        => true,
    #max_connections => 0,
    #}
    #freeradius::module::ldap { 'ad-pap':
    #server                => '10.2.24.35',
    #port                  => 389,
    #basedn                => 'DC=upr,DC=edu,DC=cu',
    #identity              => 'ras@upr.edu.cu',
    #password              => 'freeradius.upr2k18',
    #user_filter           => "(&(memberOf=cn=UPR-Ras,ou=_Gestion,dc=upr,dc=edu,dc=cu)(samAccountName=%{%{Stripped-User-Name}:-%{User-Name}})(objectclass=person))",
    #timeout               => 20,
    #group_filter          => "(objectclass=radiusprofile)",
    #}
    #freeradius::blank { ['eap.conf',]:}
    #freeradius::home_server { 'localhost':
    #secret => 'testing123',
    #type   => 'auth',
    #ipaddr => '127.0.0.1',
    #port   => 1812,
    #proto  => 'udp',
    #}
  #freeradius::home_server_pool { 'auth_failover':
  #  home_server => 'localhost',
  #  type        => 'fail-over',
  #}
  #freeradius::realm { 'pap.upr.edu.cu':
  #  acct_pool => 'localhost',
  #}
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
   #include '::cpan'
   #cpan { "Clone::Closure":
   #  ensure  => present,
   #  require => Class['::cpan'],
   #  force   => true,
   #}
   #}
