node 'noc.upr.edu.cu' {  
  class { '::basesys':
    uprinfo_usage  => 'servidor NOC',
    application    => 'Noc Server UPR',
    puppet_enabled => false,
    repos_enabled  => false,
    mta_enabled    => false,
  }
 include samba
 class { '::samba':
  share_definitions => {
    'Informatica' => {
      'comment'     => 'Repo Informatica',
      'path'        => '/repositorio/Informatica',
      'valid users' => [ 'info', ],
      'writable'    => 'yes',
    },
  }
}

}
