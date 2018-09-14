# Class: sambarepos_server
# ===========================
#
class sambarepos_server (
  Array[String] shares_name = $::sambarepos_server::params::shares_name,
  Array[String] valid_users = $::sambarepos_server::params::valid_users,
  String $path_nfs          = $::sambarepos_server::params::path_nfs, 
)inherits sambarepos_server::params {


  class { '::samba_client':
    shares_name => $::sambarepos_server::shares_name,
    valid_users => $::sambarepos_server::valid_users,
    path_nfs    => $::sambarepos_server::path_nfs,
  }

}
