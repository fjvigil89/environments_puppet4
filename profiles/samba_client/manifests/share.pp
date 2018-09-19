# == Define: samba_client::share
####
define samba_client::share (
    $shares_name = $title,
    #$valid_users = undef,
    #$path_nfs    =  undef,
){
 
class { 'samba':
  shares_definitions => {
    'shares' => {
      'comment'     => "'Repositorio de '${shares_name}",
      'path'        => '/mnt/stuff',
      'valid users' => [ 'bar', 'bob', '@foo', ],
      'writable'    => 'yes',
    },
    'public' => {
      'comment'  => 'Public Stuff',
      'path'     => '/mnt/stuff',
      'writable' => 'no',
    },
  }
}
    
}


