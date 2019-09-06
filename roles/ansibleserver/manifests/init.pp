# Class: ansibleserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class ansibleserver {

  include git
  include ansible::controller
  include ansible::target
  #ansible::add_to_group { 'frank': }

}
