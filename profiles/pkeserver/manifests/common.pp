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


}

