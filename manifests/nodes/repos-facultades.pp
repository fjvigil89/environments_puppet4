node 'repos-fact.upr.edu.cu' {

  class { '::basesys':
    uprinfo_usage  => 'servidor Repos Facultad',
    application    => 'Repos Server UPR',
    #puppet_enabled => false,
    #repos_enabled  => true,
    mta_enabled    => false,
  }

  file { "/repositorio" :
  	ensure => 'directory',
  	owner  => 'users',
  	mode   => '2777',
  }
  mount {'/repositorio':
  	device  => '10.2.25.1:/export/repos_facultades',
  	fstype  => 'nfs4',
  	ensure  => 'mounted',
  	options => 'default',
  	atboot  => true,
  }  
 
  class {'samba':
    ensure         => running,
    enable         => true,
    user_name      => 'tele',
    user_password  => '123456',
    share_name     => 'Telecomunicaciones',
    share_comment  => 'Folder comment',
    share_path     => '/repositorio/repo-fct/Telecomunicaciones',
    share_readonly => 'no',
    share_public   => 'yes',
    share_user     => 'tele',
  }
  
  class { '::apache':
  	default_vhost => false,
  	mpm_module    => 'prefork',
  }

  apache::vhost { 'repotele.upr.edu.cu non-ssl':
  	servername    => 'repotele.upr.edu.cu',
  	serveraliases => ['www.repotele.upr.edu.cu'], 
  	port          => '80',
  	docroot           => '/repositorio/repo-fct/Telecomunicaciones',
  	directories   => [ {
  		'path'           => '/repositorio/repo-fct/Telecomunicaciones',
  		'options'        => ['Indexes','FollowSymLinks','MultiViews'],
  		'allow_override' => 'All',
  		'directoryindex' => 'index.php',
  	},],
  		redirect_status  => 'permanent',
  		redirect_dest    => 'https://repotele.upr.edu.cu/',
  }~>
  apache::vhost { 'repotele.upr.edu.cu ssl':
  	servername    => 'repotele.upr.edu.cu',
  	serveraliases =>  ['www.repotele.upr.edu.cu'],
  	port          => '443',
  	docroot       => '/repositorio/repo-fct/Telecomunicaciones',
  	ssl           => true,
  	directories =>  [ {
  		'path'           => '/repositorio/repo-fct/Telecomunicaciones',
  		'options'        => ['Indexes','FollowSymLinks','MultiViews'],
  		'allow_override' => 'All',    
  		'directoryindex' => 'index.php',
  	},],
  } 

}

