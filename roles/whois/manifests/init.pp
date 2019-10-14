# Class: whois
#
class whois {
#  file { '/var/www/whois':
#    ensure => directory,
#    group  => 'root',
#    owner  => 'root',
#    mode   => '0775',
#    }~>
class{'::php_server':
  version      => '7.0',
  packages     => ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common','php7.0-gd','php7.0-gmp','php7.0-snmp'],
  manage_repos => true,
  }~>
     vcsrepo { '/var/www/whois':
       ensure   => latest,
       provider => 'git',
       remote   => 'origin',
       source   => {
         'origin' => 'git@gitlab.upr.edu.cu:dcenter/whois.git',
       },
       revision => 'master',
    }
	}
#  exec {"a2enmod_php7":
#     command => '/usr/bin/sudo a2enmod php7.0',
#     }
#  exec {"service_apache2_restart":
#     command     => '/usr/bin/sudo service apache2 restart',
#     refreshonly => true;
#     }

#Copy SSH Key

 file { '/root/.ssh/id_rsa':
   ensure => file,
   owner  => 'root',
   group  => 'root',
   mode   => '0600',
   source => 'puppet:///modules/whois/keys/id_rsa',
   }

file { '/root/.ssh/id_rsa.pub':
   ensure => file,
   owner  => 'root',
   group  => 'root',
   mode   => '0644',
   source => 'puppet:///modules/whois/keys/id_rsa.pub',
   }

 file { '/root/.ssh/config':
   ensure => file,
   owner  => 'root',
   group  => 'root',
   mode   => '0644',
   source => 'puppet:///modules/whois/keys/config',
   }
