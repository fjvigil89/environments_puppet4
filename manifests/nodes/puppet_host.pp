node 'client-puppet.upr.edu.cu'{
  

#inicio del jabbel

class { 'prosody':
    user              => 'prosody',
    group             => 'prosody',
    community_modules => ['mod_auth_ldap'],
    authentication    => 'ldap',
    custom_options    => {
                            'ldap_base'     => 'DC=upr,DC=edu,DC=cu',
                            'ldap_server'   => 'ad.upr.edu.cu:636',
                            'ldap_rootdn'   => 'DN=talk,OU=_Servicios,DC=upr,DC=edu,DC=cu',
                            'ldap_password' => '40a*talk.2k12',
                            'ldap_scope'    => 'subtree',
                            'ldap_tls'      => 'true',
                          },
  }

  prosody::virtualhost {
    'sync.upr.edu.cu' :
      ensure   => present,
      #ssl_key  => '/etc/ssl/key/sync.upr.edu.cu.key',
      #ssl_cert => '/etc/ssl/crt/sync.upr.edu.cu.crt',
  }

#fin del jabbel


  #class {'::mailserver':;}

  class { '::basesys':
  uprinfo_usage  => 'servidor test',
  application      => 'puppet',
  puppet_enabled   => false,
  mta_enabled => false,
  repos_enabled => false;
 
  }
 

  #class { '::letsencrypt_host':
   #email => 'fjvigil@hispavista.com',
   #webroot_enable => true,
   #dominios => ['sync.upr.edu.cu'],
   #plugin => 'webroot',
   #webroot_paths => ['/root/Sync-UPR/public/'],
  #}

 #class { 'apache':
  #default_vhost => false,
 #} 
 #apache::vhost { 'sync.upr.edu.cu':
  #port     => '443',
  #docroot  => '/home/Sync-UPR/public/',
  #ssl      => true,
  #docroot_owner => 'root',
  #docroot_group => 'root',
 #} 


  #class { '::php_webserver':
    #php_version    => '7.0',
    #php_extensions => {
      #'curl'     => {},
      #'gd'       => {},
      #'mysql'    => {},
      #'ldap'     => {},
      #'xml'      => {},
      #'mbstring' => {},
     
    #},
    #packages => ['php-gd', 'php-xml','php7.0-mbstring'],
  #}

}
