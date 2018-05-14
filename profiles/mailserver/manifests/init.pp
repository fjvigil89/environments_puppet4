class mailserver {

	rsyslog::snippet {
    'jchkmail_local5':
      content => "local5.*                          @logs9.ugent.be\nlocal5.*                          -/var/log/j-chkmail.log\n& ~";
    'jchkmail_local6':
      content => "local6.*                          @logs9.ugent.be\nlocal6.*                          -/var/log/j-chkmail.log\n& ~";
  }
  $overrides = {
    #'FILTER_URL' => 'http://helpdesk.ugent.be/email/',
    #'POLICY_URL' => 'http://helpdesk.ugent.be/email/faq.php',
    'USER' => 'jchkmail',
    'GROUP' => 'jchkmail',
    'SOCKET' => 'inet:7777@0.0.0.0',
    'CTRL_ACCESS' => 'ACCESS',
    'CONFDIR' => '/etc/jchkmail',
    'CLUSTER' => 'YES',
    'NOTIFY_RCPT' => 'NO',
    'XFILE_SAVE_MSG' => 'NO',
    'ACTIVE_LEARNING_MARGIN' => '',
    'SPAM_URLBL' => 'NO',

    'CHECK_SPAMTRAP_HISTORY' => 'YES',
    'CHECK_RCPT_RATE' => 'YES',
    'CHECK_RESOLVE_FAIL' => 'YES',
    'CHECK_RESOLVE_FORGED' => 'YES',

    # Limit recipient rate per from address 
    'CHECK_FROM_RCPT_RATE' => 'YES',
    # Max recipient rate per from address (can be redefined at j-policy databas
    'MAX_FROM_RCPT_RATE'   => '0',

    # Check the number of recipients per from address for each message
    'CHECK_NB_FROM_RCPT' => 'YES',
    # Max recipient per message per from address
    'MAX_FROM_RCPT' => '0',

    # Limit recipient rate per from address
    'CHECK_FROM_MSG_RATE' => 'YES',
    # Max message rate per from address (can be redefined at j-policy database)
    'MAX_FROM_MSG_RATE' => '0',

    # Limit the number of messages per from address
    'CHECK_FROM_NB_MSGS' => 'YES',
    # Maximum number of messages per from addres
    'MAX_FROM_MSGS' => '0',
    # End From Rate checks

    'BADEHLO_CHECKS' => 'InvalidChar,ForgedIP,NotBracketedIP,IdentityTheft,Regex',
    'REJECT_BADEHLO' => 'YES',
    'REJECT_DATE_IN_PAST' => 'YES',
    'DROP_DELIVERY_NOTIFICATION_REQUEST' => 'NO',

    'RESOLVE_FAIL_NETCLASS' => 'resfail',
    'RESOLVE_FORGED_NETCLASS' => 'resforged',

    'GREY_CHECK' => 'NO',
    'GREY_MODE'   => 'CLIENT',
    'GREY_SOCKET' => 'inet:2012@mcheck2.ugent.be',
    'MAX_OPEN_CONNECTIONS' => '1000',

    'CPU_IDLE_SOFT_LIMIT'  => '10',
    'CPU_IDLE_HARD_LIMIT' => '0',
  }

  class { '::jchkmail':
    jchkmail_version => '2.6.2',
    config           => $overrides;
  }
}

