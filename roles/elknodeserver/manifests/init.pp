# Class: elknodeserver
# ===========================
#
# Full description of class elknodeserver here.
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class elknodeserver{

  class {'::elknodeserver::ssh':;}~>
  class {'::elknodeserver::service':;}~>
  class {'::elknodeserver::config':;}
}
