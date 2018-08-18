# Class: nfs_client
# ===========================
#
# Full description of class nfs_client here.

class nfs_client {
  class { '::nfs_sc': 
    nfs_server    => '10.2.25.1',
    nfs_share     => 'export/repos_facultades',
    nfs_mount     => '/repositorio',
    nfs_v4_client => true,
  }
}
