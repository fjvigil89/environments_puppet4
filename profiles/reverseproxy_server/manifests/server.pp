 class reverseproxy_server::server{
   if($::reverseproxy_server::server_name)
   {
     each ($::reverseproxy_server::server_name) |Integer $index, String $value|{
       if($::reverseproxy_server::location_allow[$index] == '*')
       {
         $allow = ['any']
         $deny  = ['all']
       }
       else{
         $allow = ['200.14.49.64/27','200.55.143.160/29','10.0.0.0/8']
         $deny  = ['all']
       }
       if($::reverseproxy_server::ssl_port[$index] == 443) and ($::reverseproxy_server::listen_port[$index]== 443)
       {
         nginx::resource::server { $::reverseproxy_server::server_name[$index]:
           listen_port    => $::reverseproxy_server::listen_port[$index],
           ssl_port       => $::reverseproxy_server::ssl_port[$index],
           ssl            => true,
           ssl_cert       => "/etc/letsencrypt/live/${value}/fullchain.pem",
           ssl_key        => "/etc/letsencrypt/live/${value}/privkey.pem",
           proxy          => "https://${value}",
           server_name    => ["${value}"],
           location_allow => $allow,
           location_deny  => $deny,
         }
       }
       else{
         if($::reverseproxy_server::ssl_port[$index] == 443) and ($::reverseproxy_server::listen_port[$index]== 80){
           nginx::resource::server { $::reverseproxy_server::server_name[$index]:
             listen_port => $::reverseproxy_server::listen_port[$index],
             ssl_port    => $::reverseproxy_server::ssl_port[$index],
             ssl         => true,
             ssl_cert    => "/etc/letsencrypt/live/${value}/fullchain.pem",
             ssl_key     => "/etc/letsencrypt/live/${value}/privkey.pem",
             proxy       => "https://${value}",
             server_name => ["${value}"],
             location_allow => $allow,
             location_deny  => $deny,
           }
         }
         else{
           nginx::resource::server { $::reverseproxy_server::server_name[$index]:
             listen_port => $::reverseproxy_server::listen_port[$index],
             ssl_port    => $::reverseproxy_server::ssl_port[$index],
             proxy       => "http://${value}",
             server_name => ["${value}"],
             location_allow => $allow,
             location_deny  => $deny,
           }
         }
       }
     }
   }
} 
