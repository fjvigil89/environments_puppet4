# Class: samba_client
# ===========================
#
# Configuration  of class samba_client here.
#

class samba_client (
  String $shares_comment     = $::samba_client::params::shares_comment,
  String $shares_name        = $::samba_client::params::shares_name,
  String $shares_path        = $::samba_client::params::shares_path,
  Array[String] $valid_users = $::samba_client::params::valid_users,
  String $writable           = $::samba_client::params::writable,
  String $browseable         = $::samba_client::params::browseable,
) inherits samba_client::params {
class { 'samba':
  shares_definitions => {
    $shares_name => {
      'comment'     => $shares_comment,
      'path'        => $shares_path,
      'valid users' => $valid_users,
      'writable'    => $writable,
      'browseable'  => $browseable,
    },
  }


}
