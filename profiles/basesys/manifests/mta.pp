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
      # Appending .domain is the MUA's job.
      'append_dot_mydomain':
        value => 'no';
      'recipient_delimiter':
        value => '+';
      'inet_interfaces':
        value => 'all';
      'message_size_limit':
        value => '3072000';
      'mailbox_size_limit':
        value => '0';
      #Anti SPAM#
      'disable_vrfy_command':
        value => 'yes';
      'strict_rfc821_envelopes':
        value => 'yes';
      'content_filter':
        value => 'smtp-amavis:[127.0.0.1]:10024';
      'smtpd_client_restrictions':
        value => 'check_client_access hash:/etc/postfix/blackwhite.map';
      'smtpd_sender_restrictions':
        value => 'check_sender_access hash:/etc/postfix/blackwhite.map';
      'smtpd_relay_restrictions':
        value => 'check_recipient_access hash:/etc/postfix/blackwhite.map,reject_unauth_destination,check_policy_service inet:127.0.0.1:10026,permit';
      'smtpd_recipient_restrictions':
        value => 'reject_invalid_hostname,check_policy_service inet:127.0.0.1:10026,check_sender_access hash:/etc/postfix/access_sender,reject_rbl_client b.barracudacentral.org,permit';
      'smtpd_error_sleep_time':
        value => '60';
      'smtpd_soft_error_limit':
        value => '60';
      'smtpd_hard_error_limit':
        value => '10';
      #DKIM#
      'milter_default_action':
        value => 'accept';
      'milter_protocol':
        value => '6';
      'smtpd_milters':
        value => 'inet:localhost:8891';
      'non_smtpd_milters':
        value => 'inet:localhost:8891';
      #Max of recipient#
      'smtpd_recipient_limit':
        value => '20';
      #Headers Checks#
      'header_checks':
        value => 'pcre:/etc/postfix/header_checks.pcre';
      'body_checks':
        value => 'regexp:/etc/postfix/body_checks';
      'policy-spf_time_limit':
        value => '3600';
      #max email per user#
      'smtpd_client_event_limit_exceptions':
        value => '$mynetworks';
      'anvil_rate_time_unit': 
        value => '60s';
      'anvil_status_update_time':
        value => '120s';
      'smtpd_client_message_rate_limit':
        value => '100';



    }
  }
}
