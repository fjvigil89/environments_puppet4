# class monitoring::params
#
#============================
#
# Configure monitoring::params

class monitoring::params {
  $icinga_servers       = ['master-icinga0.upr.edu.cu']
  $icinga_ipservers     = ['10.2.4.201']
  #icinga2 params
  $icinga2server_enabled  = true
  $icinga2_dbuser         = 'icinga2web'
  $icinga2_dbname         = 'icinga2web'
  $icinga2_dbpass         = 'supersecreticinga2web'
  $icinga2_dbhost         = '127.0.0.1'
  $director_apipass       = 'icinga2web'
  $director_apiuser       = 'directoricinga2web'
  $manage_repo            = false

  #icingaweb2 params
  $icingaweb2server_enabled = true
  $icingaweb2_dbuser        = 'icinga2web'
  $icingaweb2_dbname        = 'icinga2web'
  $icingaweb2_dbpass        = 'icinga2web'
  $icingaweb2_dbhost        = 'localhost'
  $director_dbuser          = 'directoricinga2'
  $director_dbname          = 'directoricinga2'
  $director_dbpass          = 'directoricinga2'
  $director_dbhost          = '127.0.0.1'
  $ad_root_dn               = 'DC=upr,DC=edu,DC=cu'
  $ad_base_dn               = 'OU=_GrupoRedes,OU=_Usuarios,DC=upr,DC=edu,DC=cu'
  $ad_group_base_dn         = 'OU=_Gestion,DC=upr,DC=edu,DC=cu'
  $ad_bind_dn               = 'icinga2'
  $ad_bind_pw               = 'icinga.2k19.web'
}
