#
# Class monitoring::module_puppetdb
#==================================
#
# Configure monitoring::module_puppetdb

class monitoring::module_puppetdb {
#PuppetDB Icingaweb2 Module
include ::icingaweb2::module::puppetdb
$puppetdb_host    = 'puppet-master.upr.edu.cu'
$my_certname      =  $facts['fqdn']
$ssldir        = $::settings::ssldir
$web_ssldir    = '/etc/icingaweb2/modules/puppetdb/ssl'
$ssl_subdir    = "${web_ssldir}/${puppetdb_host}"

file { $ssl_subdir:
  ensure  => directory,
  source  => $ssldir,
  recurse => true,
}
~> exec { "Generate combined .pem file for ${puppetdb_host}":
  command     =>  "cat private_keys/${my_certname}.pem certs/${my_certname}.pem > private_keys/${my_certname}_combined.pem",
  path        => ['/usr/bin', '/usr/sbin', '/bin'],
  cwd         => $ssl_subdir,
  refreshonly => true
}
}



