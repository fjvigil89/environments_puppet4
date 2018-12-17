class reverseProxy::common (){
   
  class {'nginx':
     manage_repo => $::reverseProxy::manage_repo,
  }

}
