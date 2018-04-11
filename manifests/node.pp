node "client-puppet.upr.edu.cu"{
	file{"/tmp/hello":
		content => 'Hola',
	}
  cron::job{'r10k':
        minute =>  '30',
        hour =>  '*',
        date =>  '*',
        month =>  '*',
        weekday =>  '*',
        user =>  'root',
        command =>  '/opt/puppetlabs/puppet/bin/r10k deploy environment -p',
        environment =>  [ 'MAILTO=root', 'PATH="/usr/bin:/bin"' ];
  
  }
}

