# Class: basesys::dns
# ===========================
#
# DNS configuratie.
#
class basesys::proxy (
  $proxy_url    = $::basesys::proxy_url,
  $proxy_port   = $::basesys::proxy_port,
  #$proxy_user   = $::basesys::proxy_user
  #$proxy_pass   = $::basesys::proxy_pass
  ){


  if($::basesys::proxy_enabled)
  {
    file{'/etc/proxy.sh':
     ensure => 'file',
     owner  => 'root',
     group  => 'root',
     mode   => '0644',
     content => template('basesys/proxy.sh.erb'),
    }

    exec{"proxy":
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      command => "source /etc/proxy.sh",
      subscribe   => File['/etc/proxy.sh'],

    }
    #exec{"https_proxy":
    #  path     => '/usr/bin:/usr/sbin:/bin',
    #  provider => shell,
    #  command => "export https_proxy=${proxy_url}:${proxy_port}"
    #}
    #exec{"ftp_proxy":
    #  path     => '/usr/bin:/usr/sbin:/bin',
    #  provider => shell,
    #  command => "export ftp_proxy==${proxy_url}:${proxy_port}"
    #}
    #exec{"NO_Proxy":
    #  path     => '/usr/bin:/usr/sbin:/bin',
    #  provider => shell,
    #  command => "export NO_PROXY=localhost,127.0.0.1,.upr.edu.cu"
    #}
     if($::osfamily == 'Debian'){
    
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
}

