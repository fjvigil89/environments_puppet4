# Class: pkeserver
# ===========================
#
#
class pkeserver {


  class {'::pkeserver::packages':;}
  class {'::pkeserver::common':;}
  class {'::pkeserver::clonezilla':;}
  class {'::pkeserver::delete':;}

}

