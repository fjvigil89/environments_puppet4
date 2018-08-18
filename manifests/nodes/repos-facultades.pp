node 'repofct.upr.edu.cu' { 
  file { "/repositorio":
    ensure => directory,
    owner  => 'root',
    mode   => '0755',
  }
  mount {'/repositorio':
   device  => '10.2.25.1:/export/repos_facultades', 
   fstype  => 'nfs4',
   ensure  => mounted,
   options => 'default',
   atboot  => true,
  }
  include smb_rclient
}

