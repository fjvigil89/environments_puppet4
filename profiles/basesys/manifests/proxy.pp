# Class: basesys::dns
# ===========================
#
# DNS configuratie.
#
class basesys::proxy (
  ){

  $proxy_url    = $::basesys::proxy_url
  $proxy_port   = $::basesys::proxy_port
  $proxy_user   = $::basesys::proxy_user
  $proxy_pass   = $::basesys::proxy_pass

  if($::basesys::proxy_enabled)
  {
   
    exec{"http_proxy":
     command => "/usr/bin/sudo export http_proxy=${proxy_url}:${proxy_port}"
    }
    exec{"https_proxy":
     command => "/usr/bin/sudo export https_proxy=${proxy_url}:${proxy_port}"
    }
    exec{"ftp_proxy":
     command => "/usr/bin/sudo export ftp_proxy==${proxy_url}:${proxy_port}"
    }
    
    file{'/etc/apt/apt.conf.d/80proxy':
     ensure => absent,
     owner  => 'root',
     group  => 'root',
     mode   => '0644',
     source => 'puppet:///modules/basesys/80proxy',
    }


  }
}

