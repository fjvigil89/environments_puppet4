class gitlabserver (
$url_externa = 'http://localhost'
){

	class { 'gitlab':
	  external_url => $url_externa,
	  gitlab_rails => {
   		 'webhook_timeout' => 10,
    		 'gitlab_default_theme' => 2,
		  },
	  logging      => {
		 'svlogd_size' => '200 * 1024 * 1024',
		  },
	}

}
