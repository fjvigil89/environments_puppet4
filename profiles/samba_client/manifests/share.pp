# == Define: samba_client::share
####
define samba_client::share (
    $shares_name = undef,
    $valid_users = undef,
    $path_nfs    =  undef,
    $shares_definitions = 'shares_definitions',
){
 
  #include ::samba_client::params
  #class { 'samba':

   $shares_definitions = { 
     $shares_name => {
       'comment'     => "'Repositorio de '${shares_name}",
       'path'        => "${path_nfs}${shares_name}",
       'valid users' => $valid_users,
       'writable'    => 'yes',
       'browseable'  => 'yes',
     },
    }
    #}
}


