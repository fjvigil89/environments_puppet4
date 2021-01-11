node 'enotas.upr.edu.cu' {

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
  file { '/home/eNotas':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }

  class { 'apache': }
  apache::vhost { 'enotas.upr.edu.cu non-ssl':
    servername                  => 'enotas.upr.edu.cu',
    serveraliases               => ['www.enotas.upr.edu.cu'],
    port                        => '80',
    docroot                     => '/home/eNotas',
    wsgi_application_group      => '%{GLOBAL}',
    wsgi_daemon_process         => 'wsgi',
    wsgi_daemon_process_options => {
      processes                 => '2',
      threads                   => '15',
      display-name              => '%{GROUP}',
    },
    wsgi_import_script          => '/home/eNotas/',
    wsgi_import_script_options  => {
      process-group             => 'wsgi',
      application-group         => '%{GLOBAL}',
    },
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases         => { '/' => '/home/eNotas/' },
  }

}
