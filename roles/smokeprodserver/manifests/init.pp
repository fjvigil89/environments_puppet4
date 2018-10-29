#
#  Class smokeprodserver_server
#================================
#
class smokeprodserver(){
  class { 'smokeserver':
    target           => ['Router','Cisco','primero','segundo','TP'],
    pagetitle        => ['Conexión de la UPR','Cisco','primero','segundo','TP'],
    hierarchy_level  => [2,2,3,3,2],
    hierarchy_parent => ['Router','Router','Cisco','Cisco','Router'],
    host             => ['10.2.1.1','10.2.1.8','10.2.1.13','10.2.1.140','10.2.1.14'],
  }
}




  #  package { 'lsb-release':
  #  ensure => installed,
  #    }~> 
  #   class { '::basesys':
  #    uprinfo_usage => 'Servidor test',
  #    application   => 'puppet',
  #    proxmox_enabled => false,
  #  }
  #}
