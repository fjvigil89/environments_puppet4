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
  class { '::basesys':
    uprinfo_usage => 'servidor test',
    application   => 'puppet',
    repos_enabled  => true,
  }
  }
