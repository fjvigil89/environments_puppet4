# Class: samba_client::params
# ===========================
#
# Configuration  of class samba_client::params here.
#

class samba_client::params {
  
  $shares_comment = 'Share Stuff'
  $shares_name    = 'Share'
  $shares_path    = '/mnt'
  $valid_users    = ['user1','user2',]
  $writable       = 'yes'
  $browseable     = 'yes'
}
