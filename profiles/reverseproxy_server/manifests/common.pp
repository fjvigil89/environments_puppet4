class reverseproxy_server::common (){
   
  class {'nginx':
     manage_repo           => $::reverseproxy_server::manage_repo,
     proxy_connect_timeout => '180s',
     proxy_read_timeout    => '180s',
     proxy_send_timeout    => '180s',
  }

}
