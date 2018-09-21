# Class: ::nfs_client::params 
# ===========================
#
class nfs_client::params {
  $nfs_server     = '10.2.25.1'
  $nfs_share      = 'export/repos_facultades'
  $nfs_mount      = '/repositorio'
  $nfs_v4_client  = true
}
