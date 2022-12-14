# Class: kibanaserver::nginx
# ===========================
#
#
class kibanaserver::nginx {

 class {'nginx':
   manage_repo => false,
 }
 nginx::resource::server { 'elk.upr.edu.cu':
   listen_port          => 80,
   proxy                => 'http://localhost:5601',
   auth_basic           => 'Restricted Access',
   auth_basic_user_file => '/etc/nginx/htpasswd.kibana',
   proxy_set_header     => ['Host $host',"Connection 'upgrade'",'Upgrade $http_upgrade'],
   proxy_cache_bypass   => ['$http_upgrade'],
  }
  #exec{"htpasswd_kibana":
  # command => '/usr/bin/sudo echo "admin:$(openssl passwd -apr1 $*uprP@ssword*$)" | sudo tee -a /etc/nginx/htpasswd.kibana',
  #}->
  #exec{"restart_nginx":
  # command     => "/usr/bin/sudo nginx -t | systemctl restart nginx | ufw allow 'Nginx Full'",
  # refreshonly => true;
  #}

}


