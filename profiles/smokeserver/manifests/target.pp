# Class: smokeserver:target
#
#
class smokeserver::target {
  each($::smokeserver::target) |Integer $index, String $value|{
    smokeping::target{$::smokeserver::target[$index]:
      menu             => $::smokeserver::params::target[$index],
      pagetitle        => $::smokeserver::params::pagetitle[$index],
      hierarchy_level  => $::smokeserver::params::hierarchy_level[$index],
      hierarchy_parent => $::smokeserver::params::hierarchy_parent[$index],
      host             => $::smokeserver::params::host[$index],
    }
  }
}
