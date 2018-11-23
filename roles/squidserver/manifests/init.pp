# Class: squidserver
# ===========================
#
class squidserver(

)inherits ::squidserver::params {
  
  class { 'squid_server':
    http_access                    => {
      'authorized_networks' => { action => 'allow', value =>'authorized_networks', },
      'purge_localhost' => { action => 'allow', value =>'purge localhost', },
      'purge' => { action => 'deny', value =>'purge', },
      '!Safe_ports' => { action => 'deny', value =>'!Safe_ports', },
      'CONNECT !SSL_ports' => { action => 'deny', value =>'CONNECT !SSL_ports', },
      'localhost' => { action => 'allow', value =>'localhost', },
      'all' => { action => 'deny', value =>'all', },
    },
    http_ports                     => { 'http' => { port => '8080', }},
    https_ports                    => { 'https' => { port => '8443',}},
    icp_access                     => { 'icp_access'=>{ action => 'deny', value =>'all',}},
    icp_port                       => { 'icp_port'=>{ port =>'0', }},
    cache_mem                     => '2048 MB',
    maximum_object_size_in_memory => '1024 KB',
    memory_replacement_policy     => 'heap GDSF',
    cache_replacement_policy      => 'heap LFUDA',
     cache                        => {'cache'=> { action => 'allow', value =>'all', }},
    forwarded_for                  => false,
    via                            => false,

  }

}
