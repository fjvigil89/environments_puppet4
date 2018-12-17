 class reverseProxy::server{
   if($::reverseProxy::server_name)
   {
     each ($::reverseProxy::server_name) |Integer $index, String $value|{
       if($::reverseProxy::ssl_port[$index] == 443)
       {
         nginx::resource::server { $::reverseProxy::server_name[$index]:
           listen_port => $::reverseProxy::listen_port[$index],
           ssl_port    => $::reverseProxy::ssl_port[$index],
           ssl         => true,
           ssl_cert    => "/etc/letsencrypt/live/${value}/fullchain.pem",
           ssl_key     => "/etc/letsencrypt/live/${value}/privkey.pem",
           proxy       => "https://${value}.upr.edu.cu",
           server_name => ["${value}.upr.edu.cu"],
         }
       }
       else{
         nginx::resource::server { $::reverseProxy::server_name[$index]:
           listen_port => $::reverseProxy::listen_port[$index],
           ssl_port    => $::reverseProxy::ssl_port[$index],
           proxy       => "http://${value}.upr.edu.cu",
           server_name => ["${value}.upr.edu.cu"],
         }

       }

     }
   }
} 
