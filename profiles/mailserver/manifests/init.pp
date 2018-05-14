class mailserver {

	rsyslog::snippet {
    'jchkmail_local5':
      content => "local5.*                          @logs.upr.edu.cu\nlocal5.*                          -/var/log/j-chkmail.log\n& ~";
    'jchkmail_local6':
      content => "local6.*                          @logs.upr.edu.cu\nlocal6.*                          -/var/log/j-chkmail.log\n& ~";
  }

  class {'postfix':
    root_alias => 'localhost';
  }
  
  file {'/etc/postfix/main.cf':
    content => 'puppet:///profiles/mailserver/postfix/${::operatingsystem}/etc/postfix/main.cf'
  }

}

