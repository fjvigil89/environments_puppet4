# Class: smokeserver:target
#
#
class smokeserver::target(){
  each($::smokeserver::target) |Integer $index, String $value|{
    smokeping::target{ $value:
      menu             => $::smokeserver::menu[$index],
      pagetitle        => $::smokeserver::pagetitle[$index],
      hierarchy_parent => $::smokeserver::hierarchy_parent[$index],
      hierarchy_level  => $::smokeserver::hierarchy_level[$index],
      host             => $::smokeserver::host[$index],
      probe            => $::smokeserver::probes
    }
  }
}
