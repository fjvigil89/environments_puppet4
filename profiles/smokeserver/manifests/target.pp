# Class: smokeserver:target
#
#
class smokeserver::target {
  each($::smokeserver::target) |Integer $index, String $value|{
    if($::smokeserver::hierarchy_level[$index]==1)
    {
      smokeping::target {$value :
        menu      => $::smokeserver::menu[$index],
        pagetitle => $::smokeserver::menu[$index],
        alerts    => $alerts,
      }
    }
    else{
    smokeping::target{$value :
      menu             => $::smokeserver::menu[$index],
      pagetitle        => $::smokeserver::menu[$index],
      hierarchy_level  => $::smokeserver::hierarchy_level[$index],
      hierarchy_parent => $::smokeserver::hierarchy_parent[$index],
      host             => $::smokeserver::host[$index],
    }
    }
  }
  smokeping::target { 'Multihost_Routers' :
    pagetitle        => 'Routers',
    hierarchy_parent => 'Routers',
    hierarchy_level  => 2,
    menu             => 'Multihost',
    host             => ['10.2.1.1','10.2.1.8']
  }
}
