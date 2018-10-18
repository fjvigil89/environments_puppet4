# class monitoring::params
#
#============================
#
# Configure monitoring::params

class monitoring::params {
  $icinga_servers       = ['master-icinga0.upr.edu.cu','master-icinga1.upr.edu.cu']
  $icinga_ipservers     = ['10.2.1.49','10.2.1.50']
  #icinga2 params
  $icinga2server_enabled  = true
  $icinga2_dbuser         = 'icinga2'
  $icinga2_dbname         = 'icinga2'
  $icinga2_dbpass         = 'supersecret'
  $icinga2_dbhost         = '127.0.0.1'
  $director_apipass       = '123456'
  $director_apiuser       = 'director'
  #$api_users              = {}

  #icingaweb2 params
  $icingaweb2server_enabled = true
  $icingaweb2_dbuser        = 'icingaweb2'
  $icingaweb2_dbname        = 'icingaweb2'
  $icingaweb2_dbpass        = 'icingaweb2'
  $icingaweb2_dbhost        = 'localhost'
  $director_dbuser          = 'director'
  $director_dbname          = 'director'
  $director_dbpass          = 'director'
  $director_dbhost          = '127.0.0.1'
  $ad_root_dn               = 'DC=upr,DC=edu,DC=cu'
  $ad_base_dn               = 'OU=_GrupoRedes,OU=_Usuarios,DC=upr,DC=edu,DC=cu'
  $ad_group_base_dn         = 'OU=_Gestion,DC=upr,DC=edu,DC=cu'
  $ad_bind_dn               = 'icinga2'
  $ad_bind_pw               = 'web.2k17'
}
