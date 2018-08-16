# Class: nfs_sc::params
# ===========================
#
# Full description of class nfs_sc:params here.

class nfs_sc::params {
  # Server & Client parameters
  $nfs_server_enabled = false
  $nfs_client_enabled = true
  
  $nfs_v4_client = true
  $nfs_v4_idmap_domain = $::domain

  $nfs_server = 'localhost'
  $nfs_share = 'data'
  $nfs_mount = '/import/media'
}
