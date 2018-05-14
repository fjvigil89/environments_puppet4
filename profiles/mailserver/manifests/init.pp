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
    mode   => '755',
    owner  => 'root',
    group  => 'root',
    ensure => 'present',
    source => 'puppet:///profiles/mailserver/mx/main.cf',

  }

}

