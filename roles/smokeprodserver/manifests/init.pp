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
    #  smokeserver::target { ['Switch_L3_Nodo_Central','Router_PAP','Router_FCP','Router_FCF']:
    #pagetitle        => ["Switch L3 Nodo Central","Router PAP","Router FCP","Router FCF"],
    #  hierarchy_level  => 2,
    #hierarchy_parent => 'Routers',
    #host             => ['10.2.1.1','10.2.1.8','10.2.1.13','10.2.1.140','10.2.1.14'],
    # }
  #}

  # smokeping::target { ['Switch_L3_Nodo_Central','Router_PAP','Router_FCP','Router_FCF']:
  #  hierarchy_parent => ['Routers','Routers',
  #  hierarchy_level  => 2,
  #  menu             => "Switch L3 Nodo Central",
  #  pagetitle        => "Switch L3 Nodo Central",
  #  host             => '10.2.1.1',
  #}
  #smokeping::target { 'Router_PAP':
  #  hierarchy_parent => 'Routers',
  #  hierarchy_level  => 2,
  #  menu             => "Router PAP",
  #  pagetitle        => "Router PAP",
  #  host             => '10.2.1.5',
  #}
  #smokeping::target{ 'Router_FCP':
  #  hierarchy_parent => 'Routers',
  #  hierarchy_level  => 2,
  #  menu             => "Router FCP",
  #  pagetitle        => "Ruoter FCP",
  #  host             => '10.2.0.10',
  #}
  # smokeping::target { 'Router_FCF':
  #  hierarchy_parent => 'Routers',
  #  hierarchy_level  => 2,
  #  menu             => "Router FCF",
  #  pagetitle        => "Router FCF",
  #  host             => '10.2.8.200',
  #}
  #}
