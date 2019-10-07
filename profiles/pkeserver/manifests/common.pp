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
  }

  exec{"cp_pxlinux":
    command     => 'cp /usr/lib/PXELINUX/pxelinux.0 /var/lib/tftpboot/',
  }
  exec{"cp_menu32":
    command     => 'cp /usr/lib/syslinux/modules/bios/menu.c32 /var/lib/tftpboot/',
  }
  exec{"cp_ldlinux.c32 ":
    command     => 'cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /var/lib/tftpboot/',
  }
  exec{"cp_libmenu.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libmenu.c32 /var/lib/tftpboot/',
  }
  exec{"cp_libutil.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libutil.c32 /var/lib/tftpboot/',
  }
  exec{"cp_libcom32":
    command     => 'cp /usr/lib/syslinux/modules/bios/libcom32.c32 /var/lib/tftpboot/',
  }
  exec{"cp_vesamenu.c32":
    command     => 'cp /usr/lib/syslinux/modules/bios/vesamenu.c32 /var/lib/tftpboot/',
  }

}

