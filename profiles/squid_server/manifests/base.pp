# Class: squid_server::base
# =>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>
#
#
class squid_server::base
{ 
  class { 'squid':
    cache_mem                        => $squid_server::cache_mem,
    enable_service                   => $squid_server::enable_service,
    ensure_service                   => $squid_server::ensure_service,
    maximum_object_size_in_memory    => $squid_server::maximum_object_size_in_memory,
    error_directory                  => $squid_server::error_directory,
    err_page_stylesheet              => $squid_server::err_page_stylesheet,
    cache_replacement_policy         => $squid_server::cache_replacement_policy,
    memory_replacement_policy        => $squid_server::memory_replacement_policy,
    httpd_suppress_version_string    => $squid_server::httpd_suppress_version_string,
    forwarded_for                    => $squid_server::forwarded_for,
    visible_hostname                 => $squid_server::visible_hostname,
    via                              => $squid_server::via,
    acls                             => $squid_server::acls,
    auth_params                      => $squid_server::auth_params,
    cache_dirs                       => $squid_server::cache_dirs,
    cache                            => $squid_server::cache,
    coredump_dir                     => $squid_server::coredump_dir,
    url_rewrite_program              => $squid_server::url_rewrite_program,
    extra_config_sections            => {},
    http_access                      => $squid_server::http_access,
    send_hit                         => $squid_server::send_hit,
    snmp_access                      => $squid_server::snmp_access,
    http_ports                       => $squid_server::http_ports,
    https_ports                      => $squid_server::https_ports,
    icp_access                       => $squid_server::icp_access,
    icp_port                         => $squid::icp_port,
    logformat                        => $squid_server::logformat,
    buffered_logs                    => $squid_server::buffered_logs,
    max_filedescriptors              => $squid_server::max_filedescriptors,
    memory_cache_shared              => $squid_server::memory_cache_shared,
    refresh_patterns                 => $squid_server::refresh_patterns,
    snmp_incoming_address            => $squid_server::snmp_incoming_address,
    snmp_ports                       => $squid_server::snmp_ports,
    ssl_bump                         => $squid_server::ssl_bump,
    sslproxy_cert_error              => $squid_server::sslproxy_cert_error,
    workers                          => $squid_server::workers,
  }


}
