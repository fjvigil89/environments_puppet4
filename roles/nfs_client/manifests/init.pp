# Class: nfs_client
# ===========================
#
# Full description of class nfs_client here.

class nfs_client (
  String $nfs_server     = $::nfs_client::params::nfs_server,
  String $nfs_share      = $::nfs_client::params::nfs_share,
  String $nfs_mount      = $::nfs_client::params::nfs_mount,
  Boolean $nfs_v4_client = $::nfs_client::params::nfs_v4_client,
)inherits ::nfs_client::params{
  class { '::nfs_sc': 
    nfs_server    => $nfs_server,
    nfs_share     => $nfs_share,
    nfs_mount     => $nfs_mount,
    nfs_v4_client => $nfs_v4_client,
  }
}
