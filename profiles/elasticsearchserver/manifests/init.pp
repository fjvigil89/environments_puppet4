# Class: elasticsearchserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class elasticsearchserver {


  class {'::elasticsearchserver::common':;}
  class {'::elasticsearchserver::service':;}


}
