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
      if($::reverseproxy_server::location_allow[$index] == 'cuba')
       {
         $allow = ['200.55.147.104/29','200.55.187.168/29','190.6.68.0/24','200.55.130.224/29','200.55.140.128/28','200.55.141.128/28','200.55.154.160/27','200.55.177.232/29','200.55.177.240/30','200.55.187.168/29','200.55.190.168/29','196.1.112.0/24','201.220.192.0/19','169.158.0.0/16','200.55.128.0/19','200.55.160.0/19','200.55.176.0/20','190.6.64.0/20','181.225.224.0/19','190.92.112.0/20','200.13.144.0/21','181.225.224.0/19','152.206.0.0/15','200.0.24.0/22','200.14.48.0/21','190.107.0.0/20','200.13.144.0/21','200.5.12.0/22','196.1.135.0/24','196.3.152.0/24','200.0.16.0/24','190.6.0.0/16','152.206.0.0/15'] 
         $deny  = ['all']
         $red_univ= true
       }
      if($::reverseproxy_server::location_allow[$index] == 'tranversales')
       {
         $allow =['200.55.132.70','196.1.112.0/24','200.55.135.208/29','200.55.140.80/29','200.55.136.136/29','201.220.192.0/19','200.55.156.160/27','200.55.134.0/29','200.55.190.208/29','200.0.24.0/22','190.6.84.16/28','200.55.140.176/28','200.55.161.32/27','200.55.176.240/28','200.55.178.192/29','200.55.154.0/25','200.55.152.24/29','200.55.132.64/29','190.92.127.107','200.55.179.16/28','200.55.138.40/29'] 
         $deny  = ['all']
         $red_univ= true
       }
       if($::reverseproxy_server::location_allow[$index] == 'cuba_lac')
       {
         $allow =['152.206.0.0/15','169.158.0.0/16','181.225.224.0/19','190.6.64.0/20','190.6.80.0/20','190.15.144.0/20','190.92.112.0/20','190.107.0.0/20','196.1.112.0/24','196.1.135.0/24','196.3.152.0/24','200.0.16.0/24','200.0.24.0/22','200.5.12.0/22','200.13.144.0/21','200.14.48.0/21','200.55.128.0/19','200.55.160.0/20','200.55.176.0/20','201.220.192.0/20','201.220.208.0/20']
         $deny  = ['all']
         $red_univ= true
       }
       if($::reverseproxy_server::location_allow[$index] == 'todos')
       {
         $allow = ['200.14.48.0/21','10.0.0.0/8','200.55.143.8/29','152.206.71.72/29','200.55.143.160/29','190.92.126.40/29','200.55.142.16/29','200.55.142.24/29','200.55.142.32/29','200.55.142.48/29','200.55.186.32/28','200.55.139.208/28','190.6.86.168/29','190.6.94.136/29','200.55.186.216/29','200.55.139.16/28','200.55.143.192/29','200.55.145.152/29','200.55.147.64/28','200.55.149.8/29','200.55.148.248/29','200.55.148.200/29','200.55.145.8/29','200.55.162.192/28','200.55.148.24/29','200.55.148.136/29','200.55.149.136/29','200.55.136.56/29','200.55.163.24/29','190.92.113.232/29','200.55.183.40/29','200.55.140.176/28','200.55.161.32/27','200.55.176.240/28','200.55.178.192/29','190.6.91.40/29','200.55.147.104/29','200.55.187.168/29','190.6.68.0/24','200.55.130.224/29','200.55.140.128/28','200.55.141.128/28','200.55.154.160/27','200.55.177.232/29','200.55.177.240/30','200.55.187.168/29','200.55.190.168/29','196.1.112.0/24','201.220.192.0/19','169.158.0.0/16','200.55.128.0/19','200.55.160.0/19','200.55.176.0/20','190.6.64.0/20','181.225.224.0/19','190.92.112.0/20','200.13.144.0/21','181.225.224.0/19','152.206.0.0/15','200.0.24.0/22','200.14.48.0/21','190.107.0.0/20','200.13.144.0/21','200.5.12.0/22','196.1.135.0/24','196.3.152.0/24','200.0.16.0/24','190.6.0.0/16','152.206.0.0/15','200.55.132.70','196.1.112.0/24','200.55.135.208/29','200.55.140.80/29','200.55.136.136/29','201.220.192.0/19','200.55.156.160/27','200.55.134.0/29','200.55.190.208/29','200.0.24.0/22','190.6.84.16/28','200.55.140.176/28','200.55.161.32/27','200.55.176.240/28','200.55.178.192/29','200.55.154.0/25','200.55.152.24/29','200.55.132.64/29','190.92.127.107','200.55.179.16/28','200.55.138.40/29','152.206.0.0/15','169.158.0.0/16','181.225.224.0/19','190.6.64.0/20','190.6.80.0/20','190.15.144.0/20','190.92.112.0/20','190.107.0.0/20','196.1.112.0/24','196.1.135.0/24','196.3.152.0/24','200.0.16.0/24','200.0.24.0/22','200.5.12.0/22','200.13.144.0/21','200.14.48.0/21','200.55.128.0/19','200.55.160.0/20','200.55.176.0/20','201.220.192.0/20','201.220.208.0/20']
         $deny  = ['all']
         $red_univ= true
       }
       if($::reverseproxy_server::ssl_port[$index] == 443) and ($::reverseproxy_server::listen_port[$index]== 443)
       {
         if ($red_univ){
           nginx::resource::server { $::reverseproxy_server::server_name[$index]:
             listen_port        => $::reverseproxy_server::listen_port[$index],
             ssl_port           => $::reverseproxy_server::ssl_port[$index],
             ssl                => true,
             ssl_cert           => "/etc/puppetlabs/puppet/ssl/certs/${fqdn}.pem",
             ssl_key            => "/etc/puppetlabs/puppet/ssl/private_keys/${fqdn}.pem",
             #ssl_cert           => "/etc/letsencrypt/live/${value}/fullchain.pem",
             #ssl_key            => "/etc/letsencrypt/live/${value}/privkey.pem",
             proxy              => "https://${value}",
             server_name        => ["${value}"],
             location_allow     => $allow,
             location_deny      => $deny,
             proxy_set_header      => ['Host $host','X-Real-IP $remote_addr'],

           }
         }
         else{
           nginx::resource::server { $::reverseproxy_server::server_name[$index]:
             listen_port    	=> $::reverseproxy_server::listen_port[$index],
             ssl_port       	=> $::reverseproxy_server::ssl_port[$index],
             ssl            	=> true,
             ssl_cert           => "/etc/puppetlabs/puppet/ssl/certs/${fqdn}.pem",
             ssl_key            => "/etc/puppetlabs/puppet/ssl/private_keys/${fqdn}.pem",
             #ssl_cert       => "/etc/letsencrypt/live/${value}/fullchain.pem",
             #ssl_key        => "/etc/letsencrypt/live/${value}/privkey.pem",
             proxy          	=> "https://${value}",
             server_name    	=> ["${value}"],
      	     location_allow    => $allow,
             location_deny     => $deny,
             proxy_set_header   => ['Host $host','X-Real-IP $remote_addr'],

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
               ssl_cert    => "/etc/puppetlabs/puppet/ssl/certs/${fqdn}.pem",
               ssl_key     => "/etc/puppetlabs/puppet/ssl/private_keys/${fqdn}.pem",
               #ssl_cert    => "/etc/letsencrypt/live/${value}/fullchain.pem",
               #ssl_key     => "/etc/letsencrypt/live/${value}/privkey.pem",
               proxy       => "https://${value}",
               server_name => ["${value}"],
               location_allow => $allow,
               location_deny  => $deny,
               proxy_set_header      => ['Host $host','X-Real-IP $remote_addr'],

             }
           }
           else{
             nginx::resource::server { $::reverseproxy_server::server_name[$index]:
               listen_port => $::reverseproxy_server::listen_port[$index],
               ssl_port    => $::reverseproxy_server::ssl_port[$index],
               ssl         => true,
	             ssl_cert    => "/etc/puppetlabs/puppet/ssl/certs/${fqdn}.pem",
               ssl_key     => "/etc/puppetlabs/puppet/ssl/private_keys/${fqdn}.pem",
               #ssl_cert    => "/etc/letsencrypt/live/${value}/fullchain.pem",
               #ssl_key     => "/etc/letsencrypt/live/${value}/privkey.pem",
               proxy       => "https://${value}",
               server_name => ["${value}"],
               proxy_set_header      => ['Host $host','X-Real-IP $remote_addr'],

             }

           }
         }
         else{
           $port = $::reverseproxy_server::listen_port[$index]
           if($red_univ){
             nginx::resource::server { $::reverseproxy_server::server_name[$index]:
               listen_port => $::reverseproxy_server::listen_port[$index],
               #ssl_port    => $::reverseproxy_server::ssl_port[$index],
               proxy       => "http://${value}:$port" ,
               server_name => ["${value}"],
               location_allow => $allow,
               location_deny  => $deny,
               proxy_set_header      => ['Host $host','X-Real-IP $remote_addr'],

             }
           }
           else{ ## para cuando es visible para el mundo ** ##
             nginx::resource::server { $::reverseproxy_server::server_name[$index]:
               listen_port           => $::reverseproxy_server::listen_port[$index],
               proxy                 => "http://${value}:$port",
               server_name           => ["${value}"],         
               proxy_set_header      => ['Host $host','X-Real-IP $remote_addr'],
             }

           }
         }
       }
     }
   }
} 
