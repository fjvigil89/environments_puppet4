# Class: nfs_client
# ===========================
#
# Full description of class nfs_client here.

class nfs_client (
  
  Boolean $nfs_server_enabled = $::nfs_sc::params::nfs_server_enabled,
  Boolean $nfs_client_enabled = $::nfs_sc::params::nfs_client_enabled,

  String $nfs_v4_client       = $::nfs_sc::params::nfs_v4_client,
  String $nfs_v4_idmap_domain = $::nfs_sc::params::nfs_v4_client,

  String $nfs_server = $::nfs_sc::params::nfs_server,
  String $nfs_share  = $::nfs_sc::params::nfs_share
  String $nfs_mount  = $::nfs_sc::params::nfs_mount
) inherits ::nfs_sc::params{

}
