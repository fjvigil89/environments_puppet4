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


  class { 'squid':
    # http_access  => { 'our_networks hosts' => { action => 'allow', }},
    http_ports   => {'8080' => { #options => 'accel vhost', 
        }},
    https_ports   => {'8443' => { #options => 'accel vhost',
        }},
  }
  squid::acl { 'Safe_ports':
    type    => port,
    entries => ['80','443','21','70','210','1025-65535','280','488','591','777'],
  }
  squid::acl { 'CONNECT':
    type    => method,
    entries => ['CONNECT'],
  }
  squid::refresh_pattern { '^ftp:':
    min     => 1440,
    max     => 10080,
    percent => 20,
    order   => '60',
  }
  squid::refresh_pattern { '^gopher:':
    min     => 1440,
    max     => 1440,
    percent => 0,
    order   => '61',
  }
  squid::refresh_pattern { '(/cgi-bin/|\?)':
    #case_sensitive => falke,
    min            => 0,
    max            => 0,
    percent        => 0,
    order          => '62',
  }
  squid::refresh_pattern { '.':
    min     => 0,
    max     => 4320,
    percent => 20,
    order   => '63',
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
    server       => '10.2.24.35',
    port         => 389,
    basedn       => 'DC=upr,DC=edu,DC=cu',
    identity     => 'ras@upr.edu.cu',
    password     => 'freeradius.upr2k18',
    user_filter  => "(&(memberOf=cn=UPR-Ras,ou=_Gestion,dc=upr,dc=edu,dc=cu)(samAccountName=%{%{Stripped-User-Name}:-%{User-Name}})(objectclass=person))",
    timeout      => 20,
    group_filter => "(objectclass=radiusprofile)",
  }
  freeradius::blank { ['sites-enabled/default','eap.conf',]:}
  #freeradius::home_server { 'localhost':
  #  secret => 'testing123',
  #  type   => 'auth',
  #  ipaddr => '127.0.0.1',
  #  port   => 1812,
  #  proto  => 'udp',
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

  }

