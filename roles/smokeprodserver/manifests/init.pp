#
#  Class smokeprodserver_server
#================================
#
class smokeprodserver(){
  package { 'lsb-release':
    ensure => installed,
    }~> 
    class { '::basesys':
      uprinfo_usage => 'Servidor test',
      application   => 'puppet',
      proxmox_enabled => false,
    }
}
