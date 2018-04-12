node "client-puppet.upr.edu.cu"{
	file{"/tmp/hello":
		content => 'Hola del server de frank \n',
	}
  
  class {'roundcube':
      imap_host => 'ssl://localhost',
      imap_port => 993,
  }
}
