node 'noc.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor NOC',
    application    => 'Noc Server UPR',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
 class { 'samba':
  share_definitions => {
    'admin' => {
      'comment'     => 'Admin Stuff',
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

