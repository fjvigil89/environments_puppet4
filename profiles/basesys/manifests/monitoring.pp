#class: basesys::monitoring
# ===========================
#
# monitoring configuration:
# - collectd
# - ...
#
class basesys::monitoring{
  if($basesys::monitoring_enabled){
    include ::monitoring::icinga2_agent
    include ::monitoring::librenms_agent
  }
}
