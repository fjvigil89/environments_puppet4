# Class: monitoring
# ===========================
#
# Full description of class monitoring here.
#
#
class monitoring (
  #icinga2 params
  $icinga2server_enabled  = $::monitoring::params::icinga2server_enabled,
  $icinga2_dbuser         = $::monitoring::params::icinga2_dbuser,
  $icinga2_dbname         = $::monitoring::params::icinga2_dbname,
  $icinga2_dbpass         = $::monitoring::params::icinga2_dbpass,
  $icinga2_dbhost         = $::monitoring::params::icinga2_dbhost,
  $director_apipass       = $::monitoring::params::director_apipass,
  $director_apiuser       = $::monitoring::params::director_apiuser,
  $api_users              = $::monitoring::params::api_users,
  
  #icingaweb2 params
  $icingaweb2server_enabled = $::monitoring::params::icingaweb2server_enabled,
  $icingaweb2_dbuser        = $::monitoring::params::icingaweb2_dbuser,
  $icingaweb2_dbname        = $::monitoring::params::icingaweb2_dbname,
  $icingaweb2_dbpass        = $::monitoring::params::icingaweb2_dbpass,
  $icingaweb2_dbhost        = $::monitoring::params::icingaweb2_dbhost,
  $director_dbuser          = $::monitoring::params::director_dbuser,
  $director_dbname          = $::monitoring::params::director_dbname,
  $director_dbpass          = $::monitoring::params::director_dbpass,
  $director_dbhost          = $::monitoring::params::director_dbhost,
  $ad_root_dn               = $::monitoring::params::ad_root_dn,
  $ad_base_dn               = $::monitoring::params::ad_base_dn,
  $ad_group_base_dn         = $::monitoring::params::ad_group_base_dn,
  $ad_bind_dn               = $::monitoring::params::ad_bind_dn,
  $ad_bind_pw               = $::monitoring::params::ad_bind_pw,
  $director_apipass         = $::monitoring::params::director_apipass,
  $director_apiuser         = $::monitoring::params::director_apiuser,
  $icinga2_dbuser           = $::monitoring::params::icinga2_dbuser,
  $icinga2_dbname           = $::monitoring::params::icinga2_dbname,
  $icinga2_dbpass           = $::monitoring::params::icinga2_dbpass,
  $icinga2_dbhost           = $::monitoring::params::icinga2_dbhost,

) inherits ::monitoring::params {
  if($icinga2server_enabled){
    class { '::monitoring::icinga2':;}
  }
  if($icingaweb2server_enabled){
    class {'::monitoring::icingaweb2':;}
  }
}

