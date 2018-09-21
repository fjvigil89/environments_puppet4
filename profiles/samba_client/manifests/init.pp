## Class: samba_client
# ===========================
#
# Configuration  of class samba_client here.
#

class samba_client (
  String $shares_comment            = $::samba_client::params::shares_comment,
  Array[String] $shares_name        = $::samba_client::params::shares_name,
  Array[String] $shares_path        = $::samba_client::params::shares_path,
  Array[String] $valid_users        = $::samba_client::params::valid_users,
  String $writable                  = $::samba_client::params::writable,
  String $browseable                = $::samba_client::params::browseable,
  String $path_nfs                  = $::samba_client::params::path_nfs,
) inherits samba_client::params {


   class {'samba::server':
     workgroup     => 'example',
     server_string => "Example Samba Server",
     interfaces    => "eth0 lo",
     security      => 'share'
   }
  
  $shares_name.each |Integer $index, String $value|{
    $slowercase = downcase($valid_users[$index])
   samba::server::share {"$value":
     comment        => "Repositorio de ${value}",
     path           => "${path_nfs}${value}",
     browsable      => $browseable,
     writable       => $writable,
     create_mask    => 0770,
     directory_mask => 0770,
     valid_users    => $slowercase,
   }
   samba::server::user{
     user_name => $slowercase,
     password  => "123",
   }

  }

}
