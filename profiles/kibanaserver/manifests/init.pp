# Class: kibanaserver
# ===========================
#
#
class kibanaserver {

  class{'::kibanaserver::service':;}
  class{'::kibanaserver::nginx':;}

}
