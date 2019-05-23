# Class: monitoring
# ===========================
#
# Full description of class monitoring here.
#
#
class monitoring (
  Array[String]$icinga_servers    = $::monitoring::params::icinga_servers,
  Array[String]$icinga_ipservers  = $::monitoring::params::icinga_ipservers,
  #icinga2 params
  Boolean $icinga2server_enabled  = $::monitoring::params::icinga2server_enabled,
  String $icinga2_dbuser          = $::monitoring::params::icinga2_dbuser,
  String $icinga2_dbname          = $::monitoring::params::icinga2_dbname,
  String $icinga2_dbpass          = $::monitoring::params::icinga2_dbpass,
  String $icinga2_dbhost          = $::monitoring::params::icinga2_dbhost,
  String $director_apipass        = $::monitoring::params::director_apipass,
  String $director_apiuser        = $::monitoring::params::director_apiuser,
  
  
  Boolean $manage_repo            = $::monitoring::params::manage_repo,
  
  #icingaweb2 params
  Boolean $icingaweb2server_enabled = $::monitoring::params::icingaweb2server_enabled,
  String $icingaweb2_dbuser         = $::monitoring::params::icingaweb2_dbuser,
  String $icingaweb2_dbname         = $::monitoring::params::icingaweb2_dbname,
  String $icingaweb2_dbpass         = $::monitoring::params::icingaweb2_dbpass,
  String $icingaweb2_dbhost         = $::monitoring::params::icingaweb2_dbhost,
  String $director_dbuser           = $::monitoring::params::director_dbuser,
  String $director_dbname           = $::monitoring::params::director_dbname,
  String $director_dbpass           = $::monitoring::params::director_dbpass,
  String $director_dbhost           = $::monitoring::params::director_dbhost,
  String $ad_root_dn                = $::monitoring::params::ad_root_dn,
  String $ad_base_dn                = $::monitoring::params::ad_base_dn,
  String $ad_group_base_dn          = $::monitoring::params::ad_group_base_dn,
  String $ad_bind_dn                = $::monitoring::params::ad_bind_dn,
  String $ad_bind_pw                = $::monitoring::params::ad_bind_pw,

) inherits ::monitoring::params {
  if($icinga2server_enabled){
    class { '::monitoring::icinga2':;}
  }
  if($icingaweb2server_enabled){
    class {'::monitoring::icingaweb2':;}
  }
}

