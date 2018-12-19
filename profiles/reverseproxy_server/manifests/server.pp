 class reverseproxy_server::server{
   if($::reverseproxy_server::server_name)
   {
     each ($::reverseproxy_server::server_name) |Integer $index, String $value|{
       if($::reverseproxy_server::location_allow[$index] == 'red_univ')
       {
         $allow = ['200.14.48.0/21','10.0.0.0/8','200.55.143.8/29','152.206.71.72/29','200.55.143.160/29','190.92.126.40/29','200.55.142.16/29','200.55.142.24/29','200.55.142.32/29','200.55.142.48/29','200.55.186.32/28','200.55.139.208/28','190.6.86.168/29','190.6.94.136/29','200.55.186.216/29','200.55.139.16/28','200.55.143.192/29','200.55.145.152/29','200.55.147.64/28','200.55.149.8/29','200.55.148.248/29','200.55.148.200/29','200.55.145.8/29','200.55.162.192/28','200.55.148.24/29','200.55.148.136/29','200.55.149.136/29','200.55.136.56/29','200.55.163.24/29','190.92.113.232/29','200.55.183.40/29','200.55.140.176/28','200.55.161.32/27','200.55.176.240/28','200.55.178.192/29','190.6.91.40/29']
         $deny  = ['all']
         $red_univ= true
       }
       if($::reverseproxy_server::ssl_port[$index] == 443) and ($::reverseproxy_server::listen_port[$index]== 443)
       {
         if ($red_univ){
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
           nginx::resource::server { $::reverseproxy_server::server_name[$index]:
             listen_port    => $::reverseproxy_server::listen_port[$index],
             ssl_port       => $::reverseproxy_server::ssl_port[$index],
             ssl            => true,
             ssl_cert       => "/etc/letsencrypt/live/${value}/fullchain.pem",
             ssl_key        => "/etc/letsencrypt/live/${value}/privkey.pem",
             proxy          => "https://${value}",
             server_name    => ["${value}"],
           }

         }
       }
       else{
         if($::reverseproxy_server::ssl_port[$index] == 443) and ($::reverseproxy_server::listen_port[$index]== 80){
           if($red_univ){
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
               ssl         => true,
               ssl_cert    => "/etc/letsencrypt/live/${value}/fullchain.pem",
               ssl_key     => "/etc/letsencrypt/live/${value}/privkey.pem",
               proxy       => "https://${value}",
               server_name => ["${value}"],
             }

           }
         }
         else{
           if($red_univ){
             nginx::resource::server { $::reverseproxy_server::server_name[$index]:
               listen_port => $::reverseproxy_server::listen_port[$index],
               #ssl_port    => $::reverseproxy_server::ssl_port[$index],
               proxy       => "http://${value}",
               server_name => ["${value}"],
               location_allow => $allow,
               location_deny  => $deny,
             }
           }
           else{
             nginx::resource::server { $::reverseproxy_server::server_name[$index]:
               listen_port => $::reverseproxy_server::listen_port[$index],
               #ssl_port    => $::reverseproxy_server::ssl_port[$index],
               proxy       => "http://${value}",
               server_name => ["${value}"],
             }

           }
         }
       }
     }
   }
} 
