# Genomen van puppetboard::apache::vhost omdat we cas willen
# aanzetten op de vhost
# lint:ignore:inherits_across_namespaces
class puppetboardserver::apache {

  class { '::apache': }
  class { '::apache::mod::wsgi': }
  #class { '::apache::mod::auth_cas':
  # cas_login_url    => 'https://login.ugent.be/login',
   # cas_validate_url => 'https://login.ugent.be/serviceValidate';
 #}

  $vhost_name  = $::fqdn
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

  # Template Uses:
  # - $basedir
  #
  file { "${docroot}/wsgi.py":
    ensure  => present,
    content => template('puppetboard/wsgi.py.erb'),
    owner   => $user,
    group   => $group,
    require => [
      User[$user],
      Vcsrepo[$docroot],
    ],
  }

  # lint:ignore:80chars
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
      { path         => $docroot,
        options      => ['Indexes','FollowSymLinks','MultiViews'],
        auth_type    => 'CAS',
        auth_require => 'user rgevaert iddecker savdamme lukclaes fdleersn jvcamp jorschra geroggem franmaes tberton krkeppens',
      },
    ],
    require                     => File["${docroot}/wsgi.py"],
    notify                      => Service[$::puppetboard::params::apache_service],
  }
  # lint:endignore
}
# lint:endignore
