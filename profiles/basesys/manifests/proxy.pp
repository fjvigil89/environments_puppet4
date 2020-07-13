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
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      command => "export http_proxy=${proxy_url}:${proxy_port}"
    }
    exec{"https_proxy":
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      command => "export https_proxy=${proxy_url}:${proxy_port}"
    }
    exec{"ftp_proxy":
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      command => "export ftp_proxy==${proxy_url}:${proxy_port}"
    }
    
    file{'/etc/apt/apt.conf.d/80proxy':
     ensure => 'file',
     owner  => 'root',
     group  => 'root',
     mode   => '0644',
     #source => 'puppet:///modules/basesys/80proxy',
     content =>  template('basesys/80proxy.erb'),
    }


  }
}

