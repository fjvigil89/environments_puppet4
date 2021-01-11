# Class: ansibleprodserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class ansibleprodserver {

  include git
  class {"::ansibleserver":;}
  class {"::r10kserver":;}

}
