# Genomen van puppetboard::apache::vhost omdat we cas willen
# aanzetten op de vhost
# lint:ignore:inherits_across_namespaces
class puppetboardserver::apache {

  class { '::apache': }
  class { '::apache::mod::wsgi': 
	wsgi_socket_prefix => "/var/run/wsgi",
	}

  # Configure Puppetboard
  class { 'puppetboard': }
  # Access Puppetboard through pboard.example.com
  class { 'puppetboard::apache::vhost':
     vhost_name =>  'pboard.upr.edu.cu',
      port =>  80,
  }

  $vhost_name  = $::fqdn
  $wsgi_alias  = '/'
  $port        = 80
  $ssl         = false
  $ssl_cert    = undef
  $ssl_key     = undef
  $threads     = 5
  $basedir     = $::puppetboard::params::basedir
  $override    = $::puppetboard::params::apache_override

  $docroot = "${basedir}/puppetboard" 

  # lint:ignore:80chars
   ::apache::vhost { $vhost_name:   
    port                        => $port,
    docroot                     => $docroot,
    ssl                         => $ssl,
    ssl_cert                    => $ssl_cert,
    ssl_key                     => $ssl_key,
    override                    => $override,
    directories                 => [
      { path         => $docroot,
        options      => ['Indexes','FollowSymLinks','MultiViews'],
        auth_type    => 'CAS',
        auth_require => 'user frank.vigil arian',
      },
    ],
    # require                     => File["${docroot}/wsgi.py"],
    notify                      => Service[$::puppetboard::params::apache_service],
  }
  # lint:endignore
}
# lint:endignore
