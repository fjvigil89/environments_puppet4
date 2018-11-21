# Class: squid_server::base
# =>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>
#
#
class squid_server::base
{ 
  class { 'squid':
    access_log                       => $squid_server::params::access_log,
    cache_mem                        => $squid_server::params::cache_mem,
    config                           => $squid_server::params::config,
    config_group                     => $squid_server::params::config_group,
    config_user                      => $squid_server::params::config_user,
    daemon_group                     => $squid_server::params::daemon_group,
    daemon_user                      => $squid_server::params::daemon_user,
    enable_service                   => $squid_server::params::enable_service,
    ensure_service                   => $squid_server::params::ensure_service,
    maximum_object_size_in_memory    => $squid_server::params::maximum_object_size_in_memory,
    package_name                     => $squid_server::params::package_name,
    service_name                     => $squid_server::params::service_name,
    error_directory                  => $squid_server::params::error_directory,
    err_page_stylesheet              => $squid_server::params::err_page_stylesheet,
    cache_replacement_policy         => $squid_server::params::cache_replacement_policy,
    memory_replacement_policy        => $squid_server::params::memory_replacement_policy,
    httpd_suppress_version_string    => $squid_server::params::httpd_suppress_version_string,
    forwarded_for                    => $squid_server::params::forwarded_for,
    visible_hostname                 => $squid_server::params::visible_hostname,
    via                              => $squid_server::params::via,
    acls                             => $squid_server::params::acls,
    auth_params                      => $squid_server::params::auth_params,
    cache_dirs                       => $squid_server::params::cache_dirs,
    cache                            => $squid_server::params::cache,
    coredump_dir                     => $squid_server::params::coredump_dir,
    url_rewrite_program              => $squid_server::params::url_rewrite_program,
    extra_config_sections            => {},
    http_access                      => $squid_server::params::http_access,
    send_hit                         => $squid_server::params::send_hit,
    snmp_access                      => $squid_server::params::snmp_access,
    http_ports                       => $squid_server::params::http_ports,
    https_ports                      => $squid_server::params::https_ports,
    icp_access                       => $squid_server::params::icp_access,
    icp_port                         => $::squid::icp_port,
    logformat                        => $squid_server::params::logformat,
    buffered_logs                    => $squid_server::params::buffered_logs,
    max_filedescriptors              => $squid_server::params::max_filedescriptors,
    memory_cache_shared              => $squid_server::params::memory_cache_shared,
    refresh_patterns                 => $squid_server::params::refresh_patterns,
    snmp_incoming_address            => $squid_server::params::snmp_incoming_address,
    snmp_ports                       => $squid_server::params::snmp_ports,
    ssl_bump                         => $squid_server::params::ssl_bump,
    sslproxy_cert_error              => $squid_server::params::sslproxy_cert_error,
    workers                          => $squid_server::params::workers,
  }


}
