# Class: samba_client::params
# ===========================
#
# Configuration  of class samba_client::params here.
#

class samba_client::params {
  
  $shares_comment = 'Respos de '
  $shares_name    = []
  $shares_path    = ['/mnt']
  $valid_users    = ['user1','user2',]
  $read_only      = 'no'
  $browseable     = 'yes'
  $path_nfs       = '/repositorio/repo-fct/'
}
