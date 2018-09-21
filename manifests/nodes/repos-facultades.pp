node 'repos-fact.upr.edu.cu','puppet-test.upr.edu.cu' {

  #class { '::basesys':
  #  uprinfo_usage  => 'servidor Repos Facultad',
  #  application    => 'Repos Server UPR',
  #  puppet_enabled => false,
  #  repos_enabled  => true,
  #  mta_enabled    => false,
  # }
# Configure firewall settings
resources {'firewall': purge => true,}
firewall {
  '010 accept for ntp':
    dport  => '123',
    proto  => 'udp',
    action => 'accept';
  
  '011 accept for ntp':
    dport  => '123',
    proto  => 'tcp',
    action => 'accept';

  '022 accept for ssh':
    dport  => '22',
    proto  => 'tcp',
    action => 'accept';

  '053 accept for dns':
    dport  => '53',
    proto  => 'udp',
    action => 'accept';

  '056 accept for Icinga':
    dport  => '5665',
    proto  => 'tcp',
    action => 'accept';

  '161 accept for snmp':
    dport  => '161',
    proto  => 'udp',
    action => 'accept';

  '080 accept for apache':
    dport  => '80',
    proto  => 'tcp',
    action => 'accept';

  '443 accept for apache':
    dport  => '443',
    proto  => 'tcp',
    action => 'accept';

  '135 accept samba':
    dport  => '135',
    proto  => 'tcp',
    action => 'accept';

  '139 accept samba':
    dport  => '139',
    proto  => 'tcp',
    action => 'accept';

  '445 accept samba':
    dport  => '445',
    proto  => 'tcp',
    action => 'accept';

  '137 accept samba':
    dport  => '137',
    proto  => 'udp',
    action => 'accept';

  '138 accept samba':
    dport  => '138',
    proto  => 'udp',
    action => 'accept';

}

  file { "/repositorio" :
    ensure => 'directory',
    owner  => 'root',
    mode   => '2777',
  }
  mount {'/repositorio':
    device  => '10.2.25.1:/export/repos_facultades',
    fstype  => 'nfs4',
    ensure  => 'mounted',
    options => 'default',
    atboot  => true,
  }

  class { '::sambarepos_server':
     shares_name     => ['Informatica','Telecomunicaciones','Geologia','Mecanica','Fisica','DBIA','VLIR','PEIEL'],
     valid_users     => ['info','tele','geo','meca','fisica','dbia','vlir','peiel'],
     path_nfs        => '/repositorio/repo-fct/',
  }

  
  class { '::apache':
  	default_vhost => false,
  	mpm_module    => 'prefork',
  }

  apache::vhost { 'repotele.upr.edu.cu non-ssl':
  	servername    => 'repotele.upr.edu.cu',
  	serveraliases => ['www.repotele.upr.edu.cu'], 
  	port          => '80',
  	docroot           => '/repositorio/',
  	directories   => [ {
      'path'           => '/repositorio',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      'suphp'          => {
        user  => 'root',
        group => 'users',
      },
      },],
      redirect_status  => 'permanent',
      redirect_dest    => 'https://repotele.upr.edu.cu/',
  }~>
  apache::vhost { 'repotele.upr.edu.cu ssl':
  	servername    => 'repotele.upr.edu.cu',
  	serveraliases =>  ['www.repotele.upr.edu.cu'],
  	port          => '443',
  	docroot       => '/repositorio/repo-fct/Telecomunicaciones/',
    docroot_owner => 'root',
    docroot_group => 'users',
  	ssl           => true,
  	directories =>  [ {
      'path'           => '/repositorio/repo-fct/Telecomunicaciones',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',    
      'directoryindex' => 'index.php',
      #'suphp'          => {
      #  user  => 'root',
      #  group => 'users',
      #},
  	},],
  } 
  



}

