#Creacion del nodo
#
node 'mrtg-puppet.upr.edu.cu' {
  include mrtgserver
  include git
  include whois
  package { 'lsb-release':
    ensure => installed,
    }~>
    class { '::basesys':
      uprinfo_usage   => 'Servidor mrtg',
      application     => 'mrtg',
      proxmox_enabled => false,
    }
}
