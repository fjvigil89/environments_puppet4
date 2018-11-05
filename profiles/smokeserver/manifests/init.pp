# Class: smokeserver
#
#
class smokeserver(
  $owner              = $::smokeserver::params::owner,
  $mode               = $::smokeserver::params::mode,
  $cgiurl             = $::smokeserver::params::cgiurl,
  $cgi_remark_top     = $::smokeserver::params::cgi_remark_top,
  $cgi_title_top      = $::smokeserver::params::cgi_title_top,
  $alerts_to          = $::smokeserver::params::alerts_to,
  $alerts_from        = $::smokeserver::params::alerts_from,
  $alerts                           = $::smokeserver::params::alerts,
  $probes                           = $::smokeserver::params::probes,
  $manage_apache                    = $::smokeping::params::manage_apache,
  Array[String] $target             = $::smokeserver::params::target,
  Array[String] $menu               = $::smokeserver::params::menu,
  Array[String] $pagetitle          = $::smokeserver::params::pagetitle,
  Array[String] $hierarchy_parent   = $::smokeserver::params::hierarchy_parent,
  Array[Integer] $hierarchy_level   = $::smokeserver::params::hierarchy_level,
  Array[String] $host               = $::smokeserver::params::host,
)inherits ::smokeserver::params {
  class { '::smokeping':
    mode           => $mode,
    owner          => $owner,
    cgiurl         => $cgiurl,
    cgi_remark_top => $cgi_remark_top,
    cgi_title_top  => $cgi_title_top,
    probes         => $probes,
    alerts_to      => $alerts_to,
    alerts_from    => $alerts_from,
    alerts         => $alerts,
  }
  class {'::smokeserver::target':;}
}
