# Class: pkeserver
# ===========================
#
#
class pkeserver::delete {

  exec{"wget_delete":
    command     => 'rm -rf /home/frank/*',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  }

}

