# == Define: samba_client::share
####
define samba_client::share (
    $shares_name = $title,
    $valid_users = undef,
    $path_nfs    =  undef,
){
 

     $shares_name = {
       'comment'     => "'Repositorio de '${shares_name}",
       'path'        => "${path_nfs}${shares_name}",
       'valid users' => $valid_users,
       'writable'    => 'yes',
       'browseable'  => 'yes',
     }
    
}


