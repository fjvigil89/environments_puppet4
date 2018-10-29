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
  smokeping::target { 'Switch_L3_Nodo_Central':
    hierarchy_parent => 'Routers',
    hierarchy_level  => 2,
    menu             => "Switch L3 Nodo Central",
    pagetitle        => "Switch L3 Nodo Central",
    host             => '10.2.1.1',
  }
  smokeping::target { 'Router_PAP':
    hierarchy_parent => 'Routers',
    hierarchy_level  => 2,
    menu             => "Router PAP",
    pagetitle        => "Router PAP",
    host             => '10.2.1.5',
  }
  smokeping::target{ 'Router_FCP':
    hierarchy_parent => 'Routers',
    hierarchy_level  => 2,
    menu             => "Router FCP",
    pagetitle        => "Ruoter FCP",
    host             => '10.2.8.150',
  }
  smokeping::target {'Router_FCF':
    hierarchy_parent => 'Routers',
    hierarchy_level  => 2,
    menu             => "Router FCF",
    pagetitle        => "Router FCF",
    host             => '10.2.8.200',
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
