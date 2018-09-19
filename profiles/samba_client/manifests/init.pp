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
  #$var = $shares_name.each |Integer $index, String $value|{      
   $var = {
     $shares_name     =>{
       'comment'     => "'Repositorio de '${shares_name}",
       'path'        => '/mnt/stuff',
       'valid users' => [ 'bar', 'bob', '@foo', ],
       'writable'    => 'yes',
       }
   }
    
   
  
  class { 'samba':
   shares_definitions => $var, 
  }

}
