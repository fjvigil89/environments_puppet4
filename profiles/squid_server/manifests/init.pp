# Class: squid_server
# ===========================
#
#
class squid_server(
  String            $access_log                       = $squid_server::params::access_log,
  Pattern[/\d+ MB/] $cache_mem                        = $squid_server::params::cache_mem,
  String            $config                           = $squid_server::params::config,
  String            $config_group                     = $squid_server::params::config_group,
  String            $config_user                      = $squid_server::params::config_user,
  String            $daemon_group                     = $squid_server::params::daemon_group,
  String            $daemon_user                      = $squid_server::params::daemon_user,
  Boolean           $enable_service                   = $squid_server::params::enable_service,
  String            $ensure_service                   = $squid_server::params::ensure_service,
  Pattern[/\d+ KB/] $maximum_object_size_in_memory    = $squid_server::params::maximum_object_size_in_memory,
  String            $package_name                     = $squid_server::params::package_name,
  String            $service_name                     = $squid_server::params::service_name,
  Optional[Stdlib::Absolutepath] $error_directory     = $squid_server::params::error_directory,
  Optional[Stdlib::Absolutepath] $err_page_stylesheet = $squid_server::params::err_page_stylesheet,
  Optional[String]  $cache_replacement_policy         = $squid_server::params::cache_replacement_policy,
  Optional[String]  $memory_replacement_policy        = $squid_server::params::memory_replacement_policy,
  Optional[Boolean] $httpd_suppress_version_string    = $squid_server::params::httpd_suppress_version_string,
  Optional[Boolean] $forwarded_for                    = $squid_server::params::forwarded_for,
  Optional[String]  $visible_hostname                 = $squid_server::params::visible_hostname,
  Optional[Boolean] $via                              = $squid_server::params::via,
  Optional[Hash]    $acls                             = $squid_server::params::acls,
  Optional[Hash]    $auth_params                      = $squid_server::params::auth_params,
  Optional[Hash]    $cache_dirs                       = $squid_server::params::cache_dirs,
  Optional[Hash]    $cache                            = $squid_server::params::cache,
  Optional[String]  $coredump_dir                     = $squid_server::params::coredump_dir,
  Optional[Hash]    $url_rewrite_program              = $squid_server::params::url_rewrite_program,
  Optional[Hash]    $extra_config_sections            = {},
  Optional[Hash]    $http_access                      = $squid_server::params::http_access,
  Optional[Hash]    $send_hit                         = $squid_server::params::send_hit,
  Optional[Hash]    $snmp_access                      = $squid_server::params::snmp_access,
  Optional[Hash]    $http_ports                       = $squid_server::params::http_ports,
  Optional[Hash]    $https_ports                      = $squid_server::params::https_ports,
  Optional[Hash]    $icp_access                       = $squid_server::params::icp_access,
  Optional[Hash] $icp_port                            = $squid_server::params::icp_port,
  Optional[String]  $logformat                        = $squid_server::params::logformat,
  Optional[Boolean] $buffered_logs                    = $squid_server::params::buffered_logs,
  Optional[Integer] $max_filedescriptors              = $squid_server::params::max_filedescriptors,
  Optional[Variant[Enum['on', 'off'], Boolean]]
                    $memory_cache_shared              = $squid_server::params::memory_cache_shared,
  Optional[Hash]    $refresh_patterns                 = $squid_server::params::refresh_patterns,
  Optional[Stdlib::Compat::Ip_address]
                    $snmp_incoming_address            = $squid_server::params::snmp_incoming_address,
  Optional[Hash]    $snmp_ports                       = $squid_server::params::snmp_ports,
  Optional[Hash]    $ssl_bump                         = $squid_server::params::ssl_bump,
  Optional[Hash]    $sslproxy_cert_error              = $squid_server::params::sslproxy_cert_error,
  Optional[Integer] $workers                          = $squid_server::params::workers,

)inherits ::squid_server::params{
  
  class {'::squid_server::base':;}
  class {'::squid_server::common':;}

}
