# Class: haproxy_serv::backend
# ===========================
#
# Full description of class haproxy_serv::backend here.
#
#
class haproxy_serv::backend (){
  each($::haproxy_serv::backend_names) |Integer $index, String $value|{
    haproxy::backend { $::haproxy_serv::backend_names[$index]:
    mode    => $::haproxy_serv::backend_mode,
    options => $::haproxy_serv::backend_options,
  }
  }
}
