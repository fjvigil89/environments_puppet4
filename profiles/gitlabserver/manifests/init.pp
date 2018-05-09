class gitlabserver (
$url_externa = 'http://localhost'
){

	class { 'gitlab':
	  external_url => $url_externa,
	  nginx        => {
		 ssl_certificate     => '/etc/gitlab/ssl/gitlab.example.com.crt',
		 ssl_certificate_key => '/etc/gitlab/ssl/gitlab.example.com.key'
		  },
	  gitlab_rails => {
   		 'webhook_timeout' => 10,
    		 'gitlab_default_theme' => 2,
		 'ldap_enabled'	=> true,
		 'ldap_servers' => { 
		 'main'  => {
		      label				=> 'LDAP',
		      host				=> 'ad.upr.edu.cu',
		      port				=> 389,	#636,  #389
		      uid				=> 'sAMAccountName',
		      method				=> 'tls', # "tls" or "ssl" or "plain"
		      bind_dn				=> 'CN=git,OU=_Servicios,DC=upr,DC=edu,DC=cu',
		      password				=> 'mistake*tig.20',
		      active_directory			=> true,
		      allow_username_or_email_login	=> false,
		      block_auto_created_users		=> false,
		      base				=> 'DC=upr,DC=edu,DC=cu',
		      #group_base			=> 'MYGROUPBASE',
		      user_filter			=> '',				
			}
			},
		  },
	  logging      => {
		 'svlogd_size' => '200 * 1024 * 1024',
		  },
		
	}

}
