# Class: nfs_sc
# ===========================
#
# Full description of class nfs_sc here.

class nfs_sc (
  
  Boolean $nfs_server_enabled = $::nfs_sc::params::nfs_server_enabled,
  Boolean $nfs_client_enabled = $::nfs_sc::params::nfs_client_enabled,

  String $nfs_v4_client       = $::nfs_sc::params::nfs_v4_client,
  String $nfs_v4_idmap_domain = $::nfs_sc::params::nfs_v4_client,

  String $nfs_server = $::nfs_sc::params::nfs_server,
  String $nfs_share  = $::nfs_sc::params::nfs_share
  String $nfs_mount  = $::nfs_sc::params::nfs_mount
) inherits ::nfs_sc::params {
  if($nfs_client_enabled){
    node client {
       class {'::nfs':
         server_enabled      => $nfs_server_enabled,
         client_enabled      => $nfs_client_enabled,
         nfs_v4_client       => $nfs_v4_client,
         nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
       }
       nfs::client::mount { "$nfs_mount":
         server => $nfs_server,
         share  => $nfs_share,
       }
    }
  }

}
