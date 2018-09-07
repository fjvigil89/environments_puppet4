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
 
 smb_user { 'tele':                       # * user name
  ensure         => present,                  # * absent | present
  password       => 'QwertyP455aaa',          # * user password (default: random)
  force_password => true,                     # * force password value, if false   #   only set at creation (default: true)
  groups         => ['domain users',          # * list of groups (default: [])    'administrators'],
  given_name     => 'Tele',           # * user given name (default: '')
  use_username_as_cn => true,                 # * use username as cn (default: false)
  attributes     => {                         # * hash of attributes
     uidNumber   => '15222',                  #   use list for multivalued attributes
     gidNumber   => '10001',                  #   (default: {} (no attributes))
     msSFU30NisDomain => 'dc',
     mail => ['test@toto.fr'],
  },
}

 ::samba::share { 'Repositorio de Telecomunicaciones':
  path            => '/repositorio/Telecomunicaciones',  # Optionnal parameters
  manage_directory  => true,        # * let the resource handle the shared               #   directory creation (default: true)
  owner             => 'root',      # * owner of the share directory                                    #   (default: root)
  group             => 'root',      # * group of the share directory                                    #   (default: root)
  mode              => '0775',      # * mode of the share directory                                    #   (default: 0777)
  acl               => [],          # * list of posix acls (default: undef)
  options           => {            # * Custom options in section [Test Share]
    'browsable'       => 'Yes',
    'root preexec'    => 'mkdir -p \'/home/home_%U\'',
  },
  absentoptions     => ['path'],    # * Remove default settings put by this resource                                    #   default?: []
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

