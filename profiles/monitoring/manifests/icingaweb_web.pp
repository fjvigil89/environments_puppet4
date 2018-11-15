#
# Class monitoring::icingaweb_web
#==================================
#
# Configure monitoring::icingaweb_web

class monitoring::icingaweb_web {
#Installing apache or httpd
class { 'apache':
  mpm_module => 'prefork'
}

class { 'apache::mod::php': }
#Enable ModStatus
class {'apache::mod::status': }
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
    fail("Your plattform ${::osfamily} is not supported by this example.")
  }
}

apache::vhost { 'icingaweb.upr.edu.cu':
  servername => 'icingaweb.upr.edu.cu',
  port       => '80',
  docroot    => '/usr/share/icingaweb2/public',
}
# Define TimeZone in php
file_line { 'date.timezone':
  path   => '/etc/php/7.0/apache2/php.ini',
  line   => 'date.timezone = America/Havana',
  match  => '^date.timezone =',
  notify =>  Class['apache'],
}
# Apache PHP memory limit
file_line{ 'php_memory_limit':
    path   => '/etc/php/7.0/apache2/php.ini',
    line   => 'memory_limit = 1024M',
    match  => '^memory_limit =',
    notify => Class['apache'],
  }
}


