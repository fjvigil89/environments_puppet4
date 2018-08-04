
class basesys (

  String $application,
  String $uprinfo_usage,
 
  Enum['prd', 'dev', 'qas', 'tst'] $application_tier = 'prd',

  String $puppetmaster                = $::basesys::params::puppetmaster,

  Boolean $dns_enabled                = true,
  Array[String] $dnsservers           = $::basesys::params::dnsservers,
  String $dnssearchdomains            = $::basesys::params::dnssearchdomains,

  Boolean $time_enabled               = true,
  Array[String] $ntp_server           = $::basesys::params::ntp_server,
  String $ntpconf                     = $::basesys::params::ntpconf,

  Boolean $puppet_enabled        = $::basesys::params::puppet_enabled,
  String  $puppet_environment    = $::basesys::params::puppet_environment,

  Boolean $packages_enabled           = true,

  Boolean $mta_enabled                = $::basesys::params::mta_enabled,
  String $root_alias                  = $::basesys::params::root_alias,
  String $postmaster                  = $::basesys::params::postmaster,
  String $inet_interfaces             = $::basesys::params::inet_interfaces,
  String $relayhost                   = $::basesys::params::relayhost,
  String $mailname                    = $::basesys::params::mailname,

  Boolean $repos_enabled        = $::basesys::params::repos,
  String $aptly_mirror           = '',
  Boolean $backports_enabled     = false,

  Boolean $monitoring_enabled    = $::basesys::params::monitoring_enabled,
  Enum['passwd', 'ldap'] $authenticationdb = 'passwd',

  ) inherits ::basesys::params{

  class {'::basesys::repos':;}
  class {'::basesys::dns':;}
  class {'::basesys::time':;}
  class {'::basesys::packages':;}
  class {'::basesys::monitoring':;}
  class {'::basesys::puppet':;}
  class {'::basesys::mta':;}
  class {'::basesys::ssh':;}
  class {'::basesys::users':;}
  class {'::basesys::groups':;}

  case $facts['os']['family'] {
  'Debian', 'ubuntu': {
  class {'::locales':
  default_locale =>  'en_US.UTF-8',
  locales        =>  [
  'es_ES.UTF-8 UTF-8',
  'en_US.UTF-8 UTF-8',
  'nl_BE.UTF-8 UTF-8',
  'fr_BE.UTF-8 UTF-8',
  'de_BE.UTF-8 UTF-8',
  ],
  }

  }
  }



}
