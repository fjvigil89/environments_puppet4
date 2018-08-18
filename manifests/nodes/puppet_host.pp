node 'client-puppet.upr.edu.cu'{
  #class {'::talkserver':;}
  #class {'::mailserver':;}
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
  }
  #class { '::letsencrypt_host':
  #email => 'fjvigil@hispavista.com',
  #webroot_enable => true,
  #dominios => ['sync.upr.edu.cu'],
  #plugin => 'webroot',
  #webroot_paths => ['/root/Sync-UPR/public/'],
  #}
  }
node 'puppet-test.upr.edu.cu'{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
    repos_enabled  => true,
  }
  #include nfs_client
  include samba
  class { '::samba':
  share_definitions => {
    'Informatica' => {
      'comment'     => 'Repo Informatica',
      'path'        => '/repositorio/Informatica',
      'valid users' => [ 'info', ],
      'writable'    => 'yes',
    },
  }
}
  }
