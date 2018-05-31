#
# Class mailserver
#==================================
#
# Configure mailserver
class mailserver {
# lint:ignore:80chars
 rsyslog::snippet {
    'postfix_local5':
  # lint:ignore:80chars
  rsyslog::snippet {
    'jchkmail_local5':
      content => "local5.*                          @logs.upr.edu.cu\nlocal5.*                          -/var/log/j-chkmail.log\n& ~";
    'postfix_local6':
      content => "local6.*                          @logs.upr.edu.cu\nlocal6.*                          -/var/log/j-chkmail.log\n& ~";
  }

# lint:endignore

  #class {'postfix':
    #root_alias => 'localhost';
 #}
  
  # lint:endignore
  class {'postfix':
    root_alias => 'localhost';
  }
  file {'/etc/postfix/main.cf':
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    ensure => 'file',
    source => 'puppet:///profiles/mailserver/mx/main.cf',

  }

}

