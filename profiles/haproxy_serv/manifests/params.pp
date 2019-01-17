# Class: haproxy_serv::params
# ===========================
#
# Full description of class haproxy_seriv::params here.
#
#
class haproxy_serv::params {
  #Haproxy Listn parametes
  $collect_exported   = false
  $ipaddress          = $::ipaddress
  $listen_options     = {}
  $mode               = 'http'
  #Balancer Member parameters
  $listening_service  = 'service00'
  $balancer_member    = ['master00', 'master01']
  $server_names       = ['master00.upr.edu.cu', 'master01.upr.edu.cu']
  $ipaddresses        = ['10.2.0.1', '10.2.0.2']
  $ports              = ['443', '80']
  $options            = ''

  # Enable SSL/TLS options
  $enable_ssl         = false
  $frontend_name      = ['frontend_http', 'frontend_https']
  $backend_names      = ['backend00', 'backend01']
  $frontend_options   = {}
  $backend_options    = {}
  $bind               = {}
}
