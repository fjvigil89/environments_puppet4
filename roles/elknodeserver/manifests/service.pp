# Class: elknodeserver::service
# ===========================
#
# Full description of class elknodeserver here.
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class elknodeserver::service{

  include git
  class {'::elasticsearchserver':;}

}

