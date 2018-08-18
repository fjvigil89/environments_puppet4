node 'repofct.upr.edu.cu' { 
  mount {'/repositorio':
   device  => '10.2.25.1:/export/repos_facultades',
   fstype  => 'nfs',
   ensure  => mounted,
   options => 'default',
   atboot  => true,
  }
  include smb_rclient
}

