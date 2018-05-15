# Manage newrelic monitoring
# php_webserver::license_key must be set with Hiera
# application name can be set with Hiera
class php_webserver::newrelic (
  Boolean $enabled = true,
  String $license_key = 'n/a',
) {

  if($php_webserver::newrelic::enabled){
    class { '::newrelic::server::linux':
      newrelic_package_ensure => 'latest',
      newrelic_service_ensure => 'running',
      newrelic_license_key    => $license_key,
    }

    class { '::newrelic::agent::php':
      newrelic_php_package_ensure => 'latest',
      newrelic_php_service_ensure => 'running',
      newrelic_license_key        => $license_key,
    }
  }else{

    # Removel is not supported by the module.
    # This will surely work, as long as the package
    # names cross OS do not change.  If they do, a fix
    # will be needed
    package {['newrelic-sysmond','newrelic-php5']:
      ensure => absent,
    }

  }

}
