#Creacion del nodo
#
node 'mrtg.upr.edu.cu' {
  include mrtgserver
  include git
  include whois
  package { 'lsb-release':
    ensure => installed,
    }
  
#    class { '::basesys':
#      uprinfo_usage   => 'Servidor mrtg',
#      application     => 'mrtg',
#      proxmox_enabled => false,
#    }
#  class{'::php_server':
#      version      => '7.0',
#      packages     => ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common','php7.0-gd','php7.0-gmp','php7.0-snmp'],
#      manage_repos => true,
#      }
      }
  #exec{"a2enmod_php7":
  #  command => '/usr/bin/sudo a2enmod php7.0',
  #  }
#
#  exec{"service_apache2_restart":
#    command     => '/usr/bin/sudo service apache2 restart',
#    refreshonly => true;
#    }
