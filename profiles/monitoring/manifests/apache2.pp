#
# Class monitoring::apache2
#==================================
#
# Configure apache2 for icingaweb2
class { 'apache':
  mpm_module      => 'prefork'
  default_vhost   => false,
  confd_dir       => '/etc/apache2/conf-enabled',
  purge_configs   => false,
  purge_vhost_dir => true,

  include ::apache::mod::php

  apache::vhost { icingaweb.upr.edu.cu:
  servername      => icingaweb.upr.edu.cu,
  port            => '80',
  docroot         => '/var/www/redirect',
  redirect_status => 'permanent',
  redirect_dest   => "http://icingaweb.upr.edu.cu",
}

class { 'apache::mod::php': }

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
