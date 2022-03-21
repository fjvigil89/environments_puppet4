# Class: haproxy_serv::frontend
# ===========================
#
# Full description of class haproxy_serv::frontend here.
#
#
#class haproxy_serv::frontend (){
#  each($::haproxy_serv::frontend_names) |Integer $index, String $value|{
#    haproxy::backend { $::haproxy_serv::frontend_names[$index]:
#    mode    => $::haproxy_serv::frontend_mode,
#    options => $::haproxy_serv::frontend_options,
#  }
#  }
#}
