class gitlabserver (
	String $url_externa 			= $::gitlabserver::params::url_externa,
	Boolean $nginx_redirect 		= true,
	Boolean $ldap_server			= true,
	String $label				= $::gitlabserver::params::label,
	String $host                   		= $::gitlabserver::params::host,
	$port                   		= $::gitlabserver::params::port,
	String $uid                    		= $::gitlabserver::params::uid,
	String $method                 		= $::gitlabserver::params::method,	
	String $bind_dn                		= $::gitlabserver::params::bind_dn,
        String $password               		= $::gitlabserver::params::password,
        $active_directory       		= true,
        $allow_username_or_email_login 		= false,
        $block_auto_created_users 		= false,
        String $base                           	= $::gitlabserver::params::base,

){

	class { 'gitlab':
	  external_url => $url_externa,
	  nginx        => {
		 #ssl_certificate     => '/etc/gitlab/ssl/gitlab.example.com.crt',
		 #ssl_certificate_key => '/etc/gitlab/ssl/gitlab.example.com.key'
		 redirect_http_to_https	=> true
		  },
	  gitlab_rails => {
   		 'webhook_timeout' => 10,
    		 'gitlab_default_theme' => 2,
		 'ldap_enabled'	=> true,
		 'ldap_servers' => { 
		 'main'  => {
		      label				=> $label,
		      host				=> $host,
		      port				=> $port,
		      uid				=> $uid,
		      method				=> $method,
		      bind_dn				=> $bind_dn,
		      password				=> $password,
		      active_directory			=> true,
		      allow_username_or_email_login	=> false,
		      block_auto_created_users		=> false,
		      base				=> $base,
		      #group_base			=> 'MYGROUPBASE',
		      #user_filter			=> '',				
			}
			},
		  },
	  logging      => {
		 'svlogd_size' => '200 * 1024 * 1024',
		  },
	 
 	  secrets 	=> { 'gitlab_shell' 	=> { secret_token => 'asecrettoken1234567890'},
			       'gitlab_rails'	=> { secret_token => 'asecrettoken123456789010'},
			       'gitlab_ci'	=> {
					  secret_token 	  => null,
					  secret_key_base => 'asecrettoken123456789011',
					  db_key_base     => 'asecrettoken123456789012'
					}
			   },
		
	}
}
