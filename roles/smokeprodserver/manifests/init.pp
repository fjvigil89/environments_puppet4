#
#  Class smokeprodserver_server
#================================
#
class smokeprodserver(){
  include smokeserver
    smokeping::target { 'Routers':
      menu      => 'Routers',
      pagetitle => 'Routers de la UPR',
      alerts    => [ 'bigloss', 'noloss','startloss' ],
    }
    smokeping::target { 'Cisco':
      hierarchy_parent => 'Routers',
      hierarchy_level  => 2,
      menu             => 'Cisco',
      pagetitle        => 'Cisco',
    }
    smokeping::target { 'TP':
      hierarchy_parent => 'Routers',
      hierarchy_level  => 2,
      menu             => 'TP',
      host             => '10.2.1.1',
    }
    smokeping::target { 'Primero':
      hierarchy_parent => 'Cisco',
      hierarchy_level  => 3,
      menu             => 'Primero',
      host             => '10.2.1.8',
      probe            => 'FPing',
    }
    smokeping::target { 'Segundo':
      hierarchy_parent => 'TP',
      hierarchy_level  => 3,
      menu             => 'Segundo',
      host             => '10.2.1.13',
      probe            => 'FPing',
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
