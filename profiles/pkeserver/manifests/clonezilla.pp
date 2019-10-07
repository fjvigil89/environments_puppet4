# Class: pkeserver
# ===========================
#
#
class pkeserver::clonezilla {


  exec{"wget_clonezilla":
    command     => 'wget https://ftp.acc.umu.se/mirror/osdn.net/clonezilla/71563/clonezilla-live-2.6.3-7-amd64.iso',
    #refreshonly => true;
  }

}

