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
  ::samba::share { 'Test Share':
  # Mandatory parameters
  path            => '/repositorio/Informatica',

  # Optionnal parameters
  manage_directory  => true,        # * let the resource handle the shared 
                                    #   directory creation (default: true)
  owner             => 'root',      # * owner of the share directory
                                    #   (default: root)
  group             => 'root',      # * group of the share directory 
                                    #   (default: root)
  mode              => '0775',      # * mode of the share directory
                                    #   (default: 0777)
  acl               => [],          # * list of posix acls (default: undef)
  options           => {            # * Custom options in section [Test Share]
      'browsable'       => 'Yes',
      'root preexec'    => 'mkdir -p \'/home/home_%U\'',
  },
  absentoptions     => ['path'],    # * Remove default settings put by this resource
                                    #   default?: []
} 
  }
