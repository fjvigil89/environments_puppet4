node 'tunota.upr.edu.cu' {

  class { '::basesys':
    uprinfo_usage  => 'servidor enotas',
    application    => 'enotas',
    puppet_enabled => true,
    mta_enabled    => false,
    dns_preinstall => true,
  }

  #SSH
  file { '/root/.ssh/id_rsa':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/reposserver/ssh_keys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/reposserver/ssh_keys/id_rsa.pub',
  }
  file { '/root/.ssh/config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/reposserver/ssh_keys/config',
  }
  file { '/home/tunota':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }
  
  vcsrepo { '/home/tunota':
   ensure   => latest,
   provider => git,
   remote   => 'origin',
    source   => {
      'origin' => 'git@gitlab.upr.edu.cu:osmay/tunota.git',
    },
   revision => 'master',
  }

  class { 'apache': }
  apache::vhost { 'tunota.upr.edu.cu non-ssl':
    servername                  => 'tunota.upr.edu.cu',
    serveraliases               => ['www.tunota.upr.edu.cu'],
    port                        => '80',
    docroot                     => '/home/tunota',
    wsgi_application_group      => '%{GLOBAL}',
    wsgi_daemon_process         => 'wsgi',
    wsgi_daemon_process_options => {
      processes                 => '2',
      threads                   => '15',
      display-name              => '%{GROUP}',
    },
    wsgi_import_script          => '/home/tunota/',
    wsgi_import_script_options  => {
      process-group             => 'wsgi',
      application-group         => '%{GLOBAL}',
    },
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases         => { '/' => '/home/tunota/' },
  }

}
