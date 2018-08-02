# Class: basesys::mta
# ===========================
#
# Configutarion for MTA
#
class basesys::mta (
  ){

  if($::basesys::mta_enabled) {
    class { '::postfix':
        root_alias => $basesys::root_alias,
        postmaster => $basesys::postmaster,
    }

    postfix::main {
      'mydomain':
        value => $::domain;
      'myhostname':
        value => $::fqdn;
      'smtpd_helo_required':
        value => 'yes';
      'smtp_helo_name':
        value => $::fqdn;
      'smtpd_banner':
        value => '$myhostname ESMTP $mail_name';
      'append_dot_mydomanin':
        value => 'no';
      'delay_warning_time':
        value => '6h';
      'readme_directory':
        value => 'no';
      #TLS Parameters#
      'smtpd_use_tls':
        value => 'yes';
      'smtpd_tls_cert_file':
        value => '/etc/ssl/certs/ssl-cert-snakeoil.pem';
      'smtpd_tls_key_file':
        value => '/etc/ssl/private/ssl-cert-snakeoil.key';
      'smtpd_tls_session_cache_database':
        value => 'btree:${data_directory}/smtpd_scache';
      'smtp_tls_session_cache_database':
        value => 'btree:${data_directory}/smtp_scache';
      #Relay & Transports#
      'transport_maps':
        value => 'hash:/etc/postfix/transport';
      'alias_maps':
        value => 'hash:/etc/aliases';
      'alias_database':
        value => 'hash:/etc/aliases';
      'relay_domains':
        value => $::domain;
      'mydestination':
        value => '$myhostname  localhost.$mydomain  localhost';     
      'mynetworks':
        value => '127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 10.2.24.161 10.2.24.183 200.14.49.3 200.14.49.7 200.14.49.14';
      'relayhost':
        value => $basesys::relayhost;
      'inet_interfaces':
        value => $basesys::inet_interfaces;
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
