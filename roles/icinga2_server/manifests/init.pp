#
#  Class icinga2_server
#================================
#

class icinga2_server {
  include ::monitoring::icinga2
  include ::monitoring::icingaweb2
}
