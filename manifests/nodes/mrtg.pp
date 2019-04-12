#Creacion del nodo
#
node 'mrtg.upr.edu.cu' {
  include mrtgserver
  include git
  include whois
  include php
  package { 'lsb-release':
    ensure => installed,
    }~>
    class { '::basesys':
      uprinfo_usage   => 'Servidor mrtg',
      application     => 'mrtg',
      proxmox_enabled => false,
    }
  #exec{"a2enmod_php7":
  #  command => '/usr/bin/sudo a2enmod php7.0',
  #  }
#
#  exec{"service_apache2_restart":
#    command     => '/usr/bin/sudo service apache2 restart',
#    refreshonly => true;
#    }
}
