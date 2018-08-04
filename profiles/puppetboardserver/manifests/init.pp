# Class: puppetboardserver
# ===========================
#
# Full description of class puppetboardserver here.

class puppetboardserver(
  String $puppetdb_host      = 'localhost',
) {

#Add configuration below
  class {'apache':
  purge_configs => false,
  mpm_module    => 'prefork',
  default_vhost => true,
  default_mods  => false,
  }

  class { 'apache::mod::wsgi':
  wsgi_socket_prefix => '/var/run/wsgi',
  }

  $ssl_dir = $::settings::ssldir
  $puppetboard_certname = $puppetdb_host
# Configure Puppetboard
  class { 'puppetboard':
    groups              => 'puppet',
    puppetdb_key        => "${ssl_dir}/private_keys/${puppetboard_certname}.pem",
    puppetdb_ssl_verify => "${ssl_dir}/certs/ca.pem",
    puppetdb_cert       => "${ssl_dir}/certs/${puppetboard_certname}.pem",
    puppetdb_host       => $puppetdb_host,
    puppetdb_port       => 8080,
    default_environment => '*',
    manage_git          => true,
    manage_virtualenv   => true,
    reports_count       => 50
  }
  class { 'puppetboard::apache::conf': }
}
