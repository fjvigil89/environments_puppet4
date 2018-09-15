# Class: samba_client
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
  
  #    $share =  each($::samba_client::shares_name) | DataType $index, Datatype $value|{
  #   type ${value}:   
  #    'comment'     => "$shares_comment $shares_name[$index]",
  #    'path'        => "$path_nfs $shares_path[$index]",
  #    'valid users' => $valid_users[$index],
  #    'writable'    => $writable,
  #    'browseable'  => $browseable,
     
  #  }
  
  $shares = $::samba_client::shares_name.each |Integer $index, String $value|
    {
      samba_client::share{$shares_name[$index]:
        shares_name => $shares_name[$index],
        valid_users => $valid_users[$index],
        path_nfs    => $path_nfs,
      }
    }
  
 notice ($shares)  
#class { 'samba': 
#   shares_definitions =>  $shares 

#  }
}

