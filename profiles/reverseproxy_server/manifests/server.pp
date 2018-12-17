 class reverseproxy_server::server{
   if($::reverseproxy_server::server_name)
   {
     each ($::reverseproxy_server::server_name) |Integer $index, String $value|{
       if($::reverseproxy_server::ssl_port[$index] == 443)
       {
         nginx::resource::server { $::reverseproxy_server::server_name[$index]:
           listen_port => $::reverseproxy_server::listen_port[$index],
           ssl_port    => $::reverseproxy_server::ssl_port[$index],
           ssl         => true,
           ssl_cert    => "/etc/letsencrypt/live/${value}/fullchain.pem",
           ssl_key     => "/etc/letsencrypt/live/${value}/privkey.pem",
           proxy       => "https://${value}.upr.edu.cu",
           server_name => ["${value}.upr.edu.cu"],
         }
       }
       else{
         nginx::resource::server { $::reverseproxy_server::server_name[$index]:
           listen_port => $::reverseproxy_server::listen_port[$index],
           ssl_port    => $::reverseproxy_server::ssl_port[$index],
           proxy       => "http://${value}.upr.edu.cu",
           server_name => ["${value}.upr.edu.cu"],
         }

       }

     }
   }
} 
