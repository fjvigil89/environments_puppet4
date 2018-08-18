node 'repofct.upr.edu.cu' { 
  mount {'/repositorio':
   device  => '10.2.22.5:/mnt/pve/repos_facultades', 
   fstype  => 'ext4',
   ensure  => mounted,
   options => 'default',
   atboot  => true,
  }
  include smb_rclient
}

