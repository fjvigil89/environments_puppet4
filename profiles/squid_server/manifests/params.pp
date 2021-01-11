# Class: squid_server::params
# ===========================
#
#
class squid_server::params{
  $ensure_service                = 'running'
  $enable_service                = true
  $cache_mem                     = '256 MB'
  $visible_hostname              = undef
  $via                           = undef
  $httpd_suppress_version_string = undef
  $forwarded_for                 = undef
  $memory_cache_shared           = undef
  $cache_replacement_policy      = undef
  $memory_replacement_policy     = undef
  $maximum_object_size_in_memory = '512 KB'
  $coredump_dir                  = undef
  $max_filedescriptors           = undef
  $workers                       = undef
  $acls                          = undef
  $cache                         = undef
  $http_access                   = undef
  $send_hit                      = undef
  $icp_access                    = undef
  $icp_port                      = undef
  $auth_params                   = undef
  $http_ports                    = undef
  $https_ports                   = undef
  $url_rewrite_program           = undef
  $refresh_patterns              = undef
  $snmp_incoming_address         = undef
  $snmp_ports                    = undef
  $snmp_access                   = undef
  $ssl_bump                      = undef
  $sslproxy_cert_error           = undef
  $cache_dirs                    = undef
  $buffered_logs                 = undef
  $logformat                     = undef
  $error_directory               = undef
  $err_page_stylesheet           = undef


}

