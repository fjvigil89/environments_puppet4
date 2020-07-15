# Class: basesys::dns
# ===========================
#
# DNS configuratie.
#
class basesys::docker (
  $proxy_url    = $::basesys::proxy_url,
  $proxy_port   = $::basesys::proxy_port,
  #$proxy_user   = $::basesys::proxy_user
  #$proxy_pass   = $::basesys::proxy_pass
  ){


  if($::basesys::docker_enabled)
  {
    
    #file{'/etc/systemd/system/docker.service.d':
    # 		ensure => 'present',
    # 		owner  => 'root',
    # 		group  => 'root',
    # 		mode   => '0644',
    # 	}
      file{'/etc/systemd/system/docker.service.d/proxy.conf':
        ensure => 'file',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/basesys/dockerproxy.conf',
        # notify =>File['/etc/systemd/system/docker.service.d'],
      }

     exec{"daemon-reload":
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      command => "systemctl daemon-reload"
    }
    exec{"restart_docker":
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      command => "systemctl restart docker.service"
      
    }




  }
}

