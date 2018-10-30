# Class: smokeserver:target
#
#
class smokeserver::target {
  smokeping::target { 'Routers':
    menu      => 'Routers',
    pagetitle => 'Routers de la UPR',
    alerts    => $alerts,
  }
  each($::smokeserver::target) |Integer $index, String $value|{
    smokeping::target{$value :
      menu             => $::smokeserver::menu[$index],
      pagetitle        => $::smokeserver::menu[$index],
      hierarchy_level  => $::smokeserver::hierarchy_level[$index],
      hierarchy_parent => $::smokeserver::hierarchy_parent[$index],
      host             => $::smokeserver::host[$index],
    }
  }
}
