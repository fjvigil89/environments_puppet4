class gitlab {
	class { '::basesys':
    	 uprinfo_usage  => 'servidor gitlab',
   	 application      => 'puppet',
    	 puppet_enabled   => false;
  	}

	class{ '::gitlabserver':
	url_externa  => 'http://gitlab.upr.edu.cu',
        label       => 'LDAP',
        host       => 'ad.upr.edu.cu',
        port       => 389,
        uid        => 'sAMAccountName',
        method     => 'plain',
        bind_dn    => 'CN=git,OU=_Servicios,DC=upr,DC=edu,DC=cu',
        password   => 'mistake*tig.20',
        base       => 'DC=upr,DC=edu,DC=cu',
	}
}
