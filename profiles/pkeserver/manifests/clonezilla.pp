# Class: pkeserver
# ===========================
#
#
class pkeserver::clonezilla {


  exec{"wget_clonezilla":
    command     => 'wget https://ftp.acc.umu.se/mirror/osdn.net/clonezilla/71563/clonezilla-live-2.6.3-7-amd64.zip',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }->
  exec{"unzip_clonezilla":
    command     => 'unzip clonezilla-live-2.6.3-7-amd64.zip -d /var/lib/tftpboot/',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }

}

