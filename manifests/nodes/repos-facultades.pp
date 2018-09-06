node 'repofct.upr.edu.cu' {
  include repoFacult_server
 
  file { "/repositorio" :
 		ensure => 'directory',
		owner  => 'root',
		mode   => '0777',
  }
  mount {'/repositorio':
  	device  => '10.2.25.1:/export/repos_facultades',
  	fstype  => 'nfs4',
 		ensure  => 'mounted',
 		options => 'default',
 		atboot  => true,
 	}  
 
  class { '::samba_client':
  	shares_name    => 'Telecomunicaciones',
  	shares_comment => 'Repositorio de Telecomunicaciones',
  	shares_path    => '/repositorio/Telecomunicaciones',
  	valid_users    => ['tele',],
  	writable       => 'yes',
  	browseable     => 'yes',
  }
  
  class { '::apache':
  	default_vhost => false,
  	mpm_module    => 'prefork',
  }

  apache::vhost { 'repotele.upr.edu.cu non-ssl':
  	servername    => 'repotele.upr.edu.cu',
  	serveraliases => ['www.repotele.upr.edu.cu'], 
  	port          => '80',
  	docroot           => '/repositorio/Telecomunicaciones',
  	directories   => [ {
  		'path'           => '/repositorio/Telecomunicaciones',
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
  	docroot       => '/repositorio/Telecomunicaciones',
  	ssl           => true,
  	directories =>  [ {
  		'path'           => '/repositorio/Telecomunicaciones',
  		'options'        => ['Indexes','FollowSymLinks','MultiViews'],
  		'allow_override' => 'All',    
  		'directoryindex' => 'index.php',
  	},],
  } 

}

