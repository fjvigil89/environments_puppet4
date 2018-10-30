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
      menu             => $::smokeserver::params::menu[$index],
      pagetitle        => $::smokeserver::params::menu[$index],
      hierarchy_level  => $::smokeserver::params::hierarchy_level[$index],
      hierarchy_parent => $::smokeserver::params::hierarchy_parent[$index],
      host             => $::smokeserver::params::host[$index],
    }
  }
}
