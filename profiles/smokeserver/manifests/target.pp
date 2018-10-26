# Class: smokeserver:target
#
#
class smokeserver::target {
  include smokeserver::params
  each($::smokeserver::params::target) |Integer $index, String $value|{
    smokeping::target{ $value:
      menu             => $::smokeserver::params::menu[$index],
      pagetitle        => $::smokeserver::params::pagetitle[$index],
      hierarchy_parent => $::smokeserver::params::hierarchy_parent[$index],
      hierarchy_level  => $::smokeserver::params::hierarchy_level[$index],
      host             => $::smokeserver::params::host[$index],
      probe            => $::smokeserver::params::probes,
    }
  }
}
