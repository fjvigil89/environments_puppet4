# Class: nfs_client
# ===========================
#
# Full description of class nfs_client here.

class nfs_client {
  class {'::nfs_sc':
    nfs_server => '10.2.25.1',
    nfs_share  => 'repositorio',
    nfs_mount  => '/repos_facultades',
  }
}
