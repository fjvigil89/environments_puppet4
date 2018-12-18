class reverseproxy_server::common (){
   
  class {'nginx':
     manage_repo => $::reverseproxy_server::manage_repo,
  }

}
