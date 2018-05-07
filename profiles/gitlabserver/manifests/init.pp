class gitlabserver {

	class { 'gitlab':
	  external_url => 'http://gitlab.upr.edu.cu',
	}

}
