node 'news.upr.edu.cu' {

  class{'::wh_php_apache':;}
  
  apache::vhost { 'news.upr.edu.cu non-ssl':
    servername    => 'news.upr.edu.cu',
    serveraliases => ['www.news.upr.edu.cu'],
    port          => '80',
    docroot       => '/home/News-UPR/master/public/',
    directories   => [ {
      'path'           => '/home/News-UPR/master/public',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },],
      #redirect_status  => 'permanent',
      #redirect_dest    => 'https://sync.upr.edu.cu/',
  }

  exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod php7.0',
  }

  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
  }


  class {'r10kserver':
    $r10k_basedir => "/home/News-UPR",
    $cachedir     => "/var/cache/r10k",
    $configfile   => "/etc/r10k.yaml",
    $remote       => "git@gitlab.upr.edu.cu:ysantalla/app-noticias.git",
    $sources      => {
      'News-UPR' => {
        'remote'           => 'git@gitlab.upr.edu.cu:frank.vigil/webServiceAssets.git',
        'basedir'          => '/home/News-UPR',
        'prefix'           => false,
        'invalid_branches' => 'correct',
    },
  }
  } 

  #https://docs.puppetlabs.com/references/latest/type.html#sshkey
  sshkey { 'gitlab.upr.edu.cu':
    ensure => present,
    type   => 'ssh-rsa',
    target => '/root/.ssh/known_hosts',
    key    => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcODNgiShR6qzcgljO5TS64WWqelnn2rXJT7aORKeDU0TPYBZiqxnydLaMS1jlE2EBaACJac4oKVYxdZ9oKQOHdetL6KhJU0ORt1IpC7nwqxdHQ/5NT60+Rb7nDIdpHWYeXwSpCXSd1GNGsm0NJLckNZaq5Hl3VFxdwAwuQqqNVD2A861DfQE/+yQnu/ISuyO9rEarnLYeMkdlmTuL2MWub+9QVAYOzZHUZTr4/sHnZgaTfbGNoj0N+MX0bOwk8snYl7mQVSvmW5xqj5EL+t7ItSIvDhxnScGBpEY6f6wg2GDqUe48kfSMsV8PKiVSSa6d4nyE4UVmAVtgPEmX87Pj root@gitlab',
}

# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
  git_deploy_key { 'news.upr.edu.cu':
    ensure       => present,
    name         => $::fqdn,
    path         => '/root/.ssh/id_dsa.pub',
    token        => hiera('gitlab_api_token'),
    project_name => 'App-Noticias',
    server_url   => 'http://gitlab.upr.edu.cu',
    provider     => 'gitlab',
}

}
