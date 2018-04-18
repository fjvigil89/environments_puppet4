
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

  Boolean $packages_enabled           = true,

  #Boolean $monitoring_enabled    = $::basesys::params::monitoring_enabled,

  Boolean $puppet_enabled        = $::basesys::params::puppet_enabled,
  String  $puppet_environment    = $::basesys::params::puppet_environment,

  Enum['passwd', 'ldap'] $authenticationdb = 'passwd',

  ) inherits ::basesys::params {


    #  if(lookup('deploy_eyaml_test') != 'AiVai2we'){
    #    fail('Eyaml configuratie niet correct.  Eyaml decryptie stuk?')
    #}

  # Alle subclasses includen, we kijken in de subclass of we config
  # toepassen of niet.
  # Volgorde is van belang.  We moeten eerst onze repo's goed zetten
#  class {'::basesys::repos':;}
  class {'::basesys::dns':;}
#  class {'::basesys::time':;}
  class {'::basesys::packages':;}
#  class {'::basesys::paths':;}
#  class {'::basesys::ugent_info':;}
#  class {'::basesys::mta':;}
#  class {'::basesys::ssh':;}
#  class {'::basesys::hardware':;}
#  class {'::basesys::monitoring':;}
#  class {'::basesys::users':;}
#  class {'::basesys::groups':;}
#  class {'::basesys::backup':;}
#  class {'::basesys::puppet':;}
#  class {'::basesys::serverbeheer':;}
#  class {'::basesys::ugent_scripts':;}
# class {'::udev':;}
#  class {'::cronic':;}
  class {'::locales':
    default_locale => 'en_US.UTF-8',
    locales        => [
      'es_ES.UTF-8 UTF-8',
      'en_US.UTF-8 UTF-8',
      'nl_BE.UTF-8 UTF-8',
      'fr_BE.UTF-8 UTF-8',
      'de_BE.UTF-8 UTF-8',
    ],
 }

  # VMWare hosts only
#  if ($::virtual == 'vmware'){
#    class {'::basesys::vmware_guest':;}
#  }

  # Debian hosts only
#  if($::osfamily == 'Debian'){
#    class {'::basesys::unattendedupgrade':;}
#  }
}
