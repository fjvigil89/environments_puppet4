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
    # noop   => 'true',
  }
  file{'/var/lib/tftpboot/pxelinux.cfg':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    #noop   => 'true',
  }->
  file{'/var/lib/tftpboot/pxelinux.cfg/default':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/pkeserver/default',
    #noop   => 'true',
  }



  exec{"cp_pxlinux":
    command     => 'cp /usr/lib/PXELINUX/pxelinux.0 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/pxelinux.0",
  }
  exec{"cp_menu32":
    command     => 'cp /usr/lib/syslinux/modules/bios/menu.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/menu.c32",
  }
  exec{"cp_ldlinux.c32 ":
    command     => 'cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/ldlinux.c32",
  }
  exec{"cp_libmenu.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libmenu.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/libmenu.c32",
  }
  exec{"cp_libutil.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libutil.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/libutil.c32",
  }
  exec{"cp_libcom32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libcom32.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/libcom32.c32",
  }
  exec{"cp_vesamenu.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/vesamenu.c32 /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "test -f /var/lib/tftpboot/vesamenu.c32",
  }

}

