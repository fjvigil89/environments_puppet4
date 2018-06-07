#class: basesys::monitoring
# ===========================
#
# monitoring configuratie:
# - collectd
# - ...
#
class basesys::monitoring{
  if($basesys::monitoring_enabled){
    include ::monitoring::icinga2_agent
  }
}
