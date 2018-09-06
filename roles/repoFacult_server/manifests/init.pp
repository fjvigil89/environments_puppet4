# Class: repoFacult_server
# ===========================
#
#
class repoFacult_server {
  class { '::basesys':
    uprinfo_usage  => 'servidor Repos Facultad',
    application    => 'Repos Server UPR',
    #puppet_enabled => false,
    #repos_enabled  => true,
    mta_enabled    => false,
  }

  file { '/repositorio':
  ¦ ensure => 'directory',
  ¦ owner  => 'root',
  ¦ mode   => '0777',
  }
  mount {'/repositorio':
    ¦device  => '10.2.25.1:/export/repos_facultades',
    ¦fstype  => 'nfs4',
    ¦ensure  => 'mounted',
    ¦options => 'default',
    ¦atboot  => true,
  }
   
}
