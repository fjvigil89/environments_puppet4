#
# Class monitoring::apache2
#==================================
#
# Configure apache2 for icingaweb2
class { '::apache::mod::prefork': }
class { '::apache::mod::php': }
class { '::apache':
  mpm_module      => 'prefork',
  confd_dir       =>  '/etc/apache2/conf-enabled',
  purge_configs   =>  false,
  purge_vhost_dir =>  true,
}

case $::osfamily {
  'redhat': {
    package { 'php-mysql': }

    file {'/etc/httpd/conf.d/icingaweb2.conf':
     source  => 'puppet:///modules/icingaweb2/examples/apache2/icingaweb2.conf',
     require => Class['apache'],
     notify  => Service['httpd'],
  }

    package { 'centos-release-scl':
     before => Class['icingaweb2']
    }
  }
  'debian': {
    class { 'apache::mod::rewrite': }

    file {'/etc/apache2/conf.d/icingaweb2.conf':
     source  => 'puppet:///modules/icingaweb2/examples/apache2/icingaweb2.conf',
     require => Class['apache'],
     notify  => Service['apache2'],
    }
  }
default: {
  fail("Your plattform ${::osfamily} is not supported.")
}
}




