# Class: php_webserver
# ===========================
#
# Full description of class php_webserver here.
#
#
class php_webserver::params {
  $application_ensure = 'present'

  $webapp_root_dir = '/var/www'
  $web_root_suffix = ''

  $development_mode = false

  $vhost_name = $::fqdn
  $vhost_aliases = []

  $webapp_group = 'phpwebapp'
  $webapp_gid = 151000

  $webapp_users = lookup('php_webserver::users', Hash, 'hash', {})
  $webapp_user_defaults = {
    'ensure'     => 'present',
    'shell'      => '/bin/bash',
    'gid'        => $webapp_gid,
    'managehome' => true,
    'comment'    => 'php applicatie user',
  }

  $fpm_listen = '127.0.0.1:9001'

  $ssl_enabled = false
  $ssl_only = false
  $ssl_certificates = lookup('sslcert::certificates', {value_type => Hash, default_value => {}})

  $php_version = '5.6'

  $php_settings = {	
    #'PHP/max_execution_time'  => '90',
    #'PHP/max_input_time'      => '300',
    #'PHP/memory_limit'        => '-1',
    #'PHP/post_max_size'       => '32M',
    #'PHP/upload_max_filesize' => '32M',
    'Date/date.timezone'      => 'America/Havana',
  }

  $php_extensions ={} 
 
  $datadir_base = '/home'
  $datadir_base_owner = 'root'
  $datadir_base_group = 'root'

  $mount_share = false
  $sharename = ''


  $create_application_data_dir = true
  $directoryindex = 'index.php'

  $mod_security_mode = 'Off'
  $mod_security_enabled = false
  $modsec_default_rules = [
    'base_rules/modsecurity_35_bad_robots.data',
    'base_rules/modsecurity_35_scanners.data',
    'base_rules/modsecurity_40_generic_attacks.data',
    'base_rules/modsecurity_50_outbound.data',
    'base_rules/modsecurity_50_outbound_malware.data',
    'base_rules/modsecurity_crs_20_protocol_violations.conf',
    'base_rules/modsecurity_crs_21_protocol_anomalies.conf',
    'base_rules/modsecurity_crs_23_request_limits.conf',
    'base_rules/modsecurity_crs_30_http_policy.conf',
    'base_rules/modsecurity_crs_35_bad_robots.conf',
    'base_rules/modsecurity_crs_40_generic_attacks.conf',
    # it blocks symfony forms
    # 'base_rules/modsecurity_crs_41_sql_injection_attacks.conf',
    'base_rules/modsecurity_crs_41_xss_attacks.conf',
    'base_rules/modsecurity_crs_42_tight_security.conf',
    'base_rules/modsecurity_crs_45_trojans.conf',
    'base_rules/modsecurity_crs_47_common_exceptions.conf',
    'base_rules/modsecurity_crs_49_inbound_blocking.conf',
    'base_rules/modsecurity_crs_50_outbound.conf',
    'base_rules/modsecurity_crs_59_outbound_blocking.conf',
    'base_rules/modsecurity_crs_60_correlation.conf',
  ]

  $csp = {
    'default-src' => '\'self\' *.upr.edu.cu \'unsafe-inline\' \'unsafe-eval\'',
  }


  $csp_key_value = $csp.map |$key, $value| { "${key} ${value};" }

  $security_headers_enable = false
  $default_security_headers = {
    'Content-Security-Policy'   => join($csp_key_value, ''),
    'Strict-Transport-Security' => 'max-age=63072000; includeSubdomains;',
    'X-Content-Type-Options'    => 'nosniff',
    'X-Frame-Options'           => 'SAMEORIGIN',
    'X-Xss-Protection'          => '1; mode=block',
    'Referrer-Policy'           => 'origin',
  }

  $set_env = { }

  $newrelic_enabled = false
}
