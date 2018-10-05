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
  #include dns_primary

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
  class {'::serv_logrotate':
    compress         => true, 
    filelog_numbers  => [5,7],
    rotate_frecuency => ['week'],
    rule_list        => ['messages', 'apache'],
    log_path         => ['/var/log/messages', '/var/log/apache2/*.log'],
  }
class { 'freeradius':
  max_requests    => 4096,
  max_servers     => 4096,
  mysql_support   => true,
  utils_support   => true,
  syslog          => true,
  log_auth        => 'yes',
  }
class { 'freeradius::status_server':
  port   => '18120',
  secret => 't0pSecret!',
}
freeradius::sql { 'radius':
  database  => 'mysql',
  server    => 'localhost',
  login     => 'radius',
  password  => 'topsecret',
  radius_db => 'radius',
}
class { 'freeradius::listen':
type      => 'auth',
ip        => '*',
interface => 'eth0',
}
  #include freeradius_server 
   #class {'::firewallprod':
   #  hosts_todrop   => ['111.111.111.111', '50.138.112.159', '31.220.16.147'],
   #  hosts_toaccept => ['200.55.143.160/29','200.55.153.64/28'],
   #  chain_from     => 'from-reduniv',
   #  chain_to       => 'to-reduniv',
   #  open_ports     => [8080,443,53,22],
   #}

  }

