# Class: talk_prodserver
# ===========================
#
# Full description of class talk_prodserver here.
#
class talk_prodserver {
  package { 'lsb-release':
    ensure =>  installed,
    }~>
    class { '::basesys':
      uprinfo_usage  => 'servidor jabbel',
      application    => 'production',
      mta_enabled    => false,
    }
class talkserver{
  $user           => $::talkserver::params::user,
  $group          => $::talkserver::params::group,
  $authentication => $::talkserver::params::authentication,
  $ldap_base      => $::talkserver::params::ldap_base,
  $ldap_server    => $::talkserver::params::ldap_server,
  $ldap_rootdn    => $::talkserver::params::ldaprootdn,
  $ldap_password  => $::talkserver::params::ldap_password,
}
}
