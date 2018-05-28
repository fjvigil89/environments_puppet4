# Class: basesys::mta
# ===========================
#
# mta configuratie.  mta
#
class basesys::mta (
  ){

  if($::basesys::mta_enabled) {
    class {
      '::postfix':
        root_alias => $basesys::root_alias,
        postmaster => $basesys::postmaster,
    }

    postfix::main {
      'mydomain':
        value => $::domain;
      'relayhost':
        value => $basesys::relayhost;
      'inet_interfaces':
        value => $basesys::inet_interfaces;
      'mynetworks':
        value => '127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128';
      'mydestination':
        value => '$myhostname  localhost.$mydomain  localhost';
      'smtpd_banner':
        value => '$myhostname ESMTP $mail_name';
      'mailbox_size_limit':
        value => '0';
      # Appending .domain is the MUA's job.
      'append_dot_mydomain':
        value => 'no';
      'recipient_delimiter':
        value => '+';
      'message_size_limit':
        value => '26214400';
    }
  }
}
