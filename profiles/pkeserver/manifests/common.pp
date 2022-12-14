# Class: pkeserver
# ===========================
#
#
class pkeserver::common {

   file{'/var/lib/tftpboot':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  file{'/var/lib/tftpboot/pxelinux.cfg':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }->
  file{'/var/lib/tftpboot/pxelinux.cfg/default':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/pkeserver/default',
  }->
  file{'/etc/dnsmasq.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/pkeserver/dnsmasq',
    notify => Service[dnsmasq]
  }

  notify {'tftpboot has already been':
      require => File['/var/lib/tftpboot'],
    }


  service { 'dnsmasq' :
    ensure => running
  }

  exec{"cp_pxlinux":
    command     => 'cp /usr/lib/PXELINUX/pxelinux.0 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }
  exec{"cp_menu32":
    command     => 'cp /usr/lib/syslinux/modules/bios/menu.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }
  exec{"cp_ldlinux.c32 ":
    command     => 'cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }
  exec{"cp_libmenu.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libmenu.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }
  exec{"cp_libutil.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libutil.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }
  exec{"cp_libcom32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libcom32.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }
  exec{"cp_vesamenu.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/vesamenu.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }

}

