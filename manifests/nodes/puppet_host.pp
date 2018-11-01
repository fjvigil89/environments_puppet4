node 'client-puppet.upr.edu.cu'{
  #class {'::talkserver':;}
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',  
    repos_enabled => false, 
  }
  #class { '::letsencrypt_host':
  #email => 'fjvigil@hispavista.com',
  #webroot_enable => true,
  #dominios => ['sync.upr.edu.cu'],
  #plugin => 'webroot',
  #webroot_paths => ['/root/Sync-UPR/public/'],
  #}
  #class {'dhcpserver':
  #    interfaces   => ['eth0'],
  #    pool_enabled => true,
  #    pool         => ['Assets'],
  #    network      => ['10.2.202.0'],
  #    mask         => ['255.255.255.0'],
  #    range        => ['10.2.202.2 10.2.202.5'],
  #    gateway      => ['10.2.202.1'],
  #    host_enabled => true,
  #    host         => ['profes.upr.edu.cu'],
  #    comment      => ['este es el host para el proxy de profesores'],
  #    mac          => ['72:92:c5:24:74:e4'],
  #    ip           => ['10.2.202.3']
  #  }
 
  #include dns_primary

}


node 'test.upr.edu.cu'{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
  }
  include freeradius_server 
  #include nfs_client
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
  class{'::wh_php_apache':;}
  apache::vhost { 'smokeping.upr.edu,cu':
    port          => '80',
    docroot       => '/usr/share/smokeping/smokeping.cgi',
    suphp_engine  => 'on',
    scriptalias   => '/usr/lib/cgi-bin',
    servername    => 'smokeping.upr.edu.cu',
    serveraliases => 'www.smokeping.upr.edu.cu',
    directories   => [ {
      'path'           => '/usr/share/smokeping/www',
      'options'        => ['FollowSymLinks'],
      'allow_override' => 'All',
      },],
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
