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
    target           => ['L3','PAP','FCP','FCF'],
    menu             => ['Switch L3 Nodo Central','Router PAP','Router FCP','Router FCF'],
    hierarchy_level  => [2],
    hierarchy_parent => ['Routers'],
    host             => ['10.2.1.1','10.2.1.5','10.2.0.10','10.2.8.200'],
  }
}
# class { 'smokeserver':
#    target           => ['Router','Cisco','primero','segundo','TP'],
#    pagetitle        => ['Conexión de la UPR','Cisco','primero','segundo','TP'],
#    hierarchy_level  => [2,2,3,3,2],
#    hierarchy_parent => ['Router','Router','Cisco','Cisco','Router'],
#    host             => ['10.2.1.1','10.2.1.8','10.2.1.13','10.2.1.140','10.2.1.14'],
#  }
#}
  #  class { '::smokeping':
  #   mode   => 'standalone',
  #   probes => [
  #     { name => 'FPing', binary => '/usr/bin/fping' },
  #     { name => 'FPing6', binary => '/usr/bin/fping6' },
  #     { name => 'Curl',  binary => '/usr/bin/curl'},
  #   ],
  #   alerts => [
  #     {
  #       name       => 'bigloss',
  #       alert_type => 'loss',
  #       pattern    => '==0%,==0%,==0%,==0%,>0%,>0%,>0%',
  #       comment    => 'suddenly there is packet loss',
  #     },
  #     {
  #       name       => 'startloss',
  #       alert_type => 'loss',
  #       pattern    => '==S,>0%,>0%,>0%',
  #       comment    => 'loss at startup',
  #     },
  #     {
  #       name        => 'noloss',
  #       alert_type  => 'loss',
  #       pattern     => '>0%,>0%,>0%,==0%,==0%,==0%,==0%',
  #       edgetrigger => true,
  #       comment     => 'there was loss and now its reachable again',
  #     },
  #   ],
  # }
  #   smokeping::target { 'World':
  #     menu      => 'World',
  #     pagetitle => 'Connection to the World',
  #     alerts    => [ 'bigloss', 'noloss' ],
  #   }
  #   smokeping::target { 'GoogleCH':
  #     hierarchy_parent => 'World',
  #     hierarchy_level  => 2,
  #     menu             => 'google.ch',
  #     pagetitle        => 'Google',
  #   }
  #   smokeping::target { 'GoogleCHIPv4':
  #     hierarchy_parent => 'GoogleCH',
  #     hierarchy_level  => 3,
  #     menu             => 'google.ch IPv4',
  #     host             => 'google.ch',
  #   }
  #   smokeping::target { 'GoogleCHIPv6':
  #     hierarchy_parent => 'GoogleCH',
  #     hierarchy_level  => 3,
  #     menu             => 'google.ch IPv6',
  #     host             => 'google.ch',
  #     probe            => 'FPing6',
  #   }
  #   smokeping::target { 'GoogleCHCurl':
  #     hierarchy_parent => 'GoogleCH',
  #     hierarchy_level  => 3,
  #     menu             => 'google.ch Curl',
  #     host             => 'google.ch',
  #     probe            => 'Curl',
  #     options          => {
  #       urlformat => 'http://%host%/',
  #     }
  #   }
  # }
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
