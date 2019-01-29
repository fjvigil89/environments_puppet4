## Manage Apache config 

class mrtgserver::apache(){
  case $facts['operatingsystem'] {
    'CentOS', 'RedHat': {
      if $facts['architecture'] == 'x86_64' {
        package { 'httpd':
          name   => 'httpd.x86_64',
          ensure => installed,
        }
      }
      else {
        package { 'httpd':
          name   => 'httpd.i386',
          ensure => installed,
        }
      }
      service { 'httpd':
        ensure => running,
        enable => true,
      }
      file { 'http.conf':
        path   => '/etc/httpd/conf/httpd.conf',
        owner  => $owner,
        group  => $group,
        mode   => $mode,
        ensure => present,
        }
      }
    'Debian', 'Ubuntu': {
      package { 'apache2':
        name   => 'apache2',
        ensure => installed,
      }
      service {'apache2':
        ensure => running,
        enable => true,
      }
      file { 'apache2.conf':
        path   => '/etc/apache2/apache2.conf',
        owner  => $owner,
        group  => $group,
        mode   => $mode,
        ensure => present,
      }
    }
    default : {}
  }
  apache::vhost { 'mrtg':
    port          => '80',
    docroot       => '/var/www/mrtgpup',
    servername    => 'mrtg-pup.upr.edu.cu',
    aliases       => 'mrtg',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
  }
}
