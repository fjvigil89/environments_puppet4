# Class: freeradius_server::params
# ===========================
#
# Full description of class freedaruis_server::params here.
#
class freeradius_server::params{ 
  $package   = ['freeradius', 'freeradius-mysql','freeradius-utils']
  $conf_path = '/etc/freeradius/3.0'
}
