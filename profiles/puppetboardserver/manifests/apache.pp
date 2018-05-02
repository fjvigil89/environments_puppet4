# Genomen van puppetboard::apache::vhost omdat we cas willen
# aanzetten op de vhost
# lint:ignore:inherits_across_namespaces
class puppetboardserver::apache {

  class { '::apache': }
  class { '::apache::mod::wsgi':}

  $host_name  = $::fqdn
  $wsgi_alias  = '/'
  $port        = 80
  $ssl         = false
  $ssl_cert    = undef
  $ssl_key     = undef
  $threads     = 5
  $user        = $::puppetboard::params::user
  $group       = $::puppetboard::params::group
  $basedir     = $::puppetboard::params::basedir
  $override    = $::puppetboard::params::apache_override
  $docroot = "${basedir}/puppetboard"
  
  $wsgi_script_aliases = {
    "${wsgi_alias}" => "${docroot}/wsgi.py",    
  }
  
  $wsgi_daemon_process_options = {
    threads => $threads,
    group   => $group,
    user    => $user,
    
  }

  #  ::ate Uses:
  # - $basedir
  #
  file { "${docroot}/wsgi.py":
    ensure   => present,
    content  => template('puppetboard/wsgi.py.erb'),
    owner    => $user,
    group    => $group,
    require  => [
     User[$user],
     Vcsrepo[$docroot],
     ],
    }
    
  }




  #nt:ignore:80chars
    ::apache::vhost { $vhost_name:
      port                        => $port,
      docroot                     => $docroot,
      ssl                         => $ssl,
      ssl_cert                    => $ssl_cert,
      ssl_key                     => $ssl_key,
      wsgi_daemon_process         => $user,
      wsgi_process_group          => $group,
      wsgi_script_aliases         => $wsgi_script_aliases,
      wsgi_daemon_process_options => $wsgi_daemon_process_options,
      override                    => $override,
      directories                 => [
      { path                      => $docroot,
      options                     => ['Indexes','FollowSymLinks','MultiViews'],
       ],
      require                     => File["${docroot}/wsgi.py"],
      notify                      => Service[$::puppetboard::params::apache_service],
      }
      

}
# lint:endignore

}
