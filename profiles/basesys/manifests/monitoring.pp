#class: basesys::monitoring
# ===========================
#
# monitoring configuration:
# - icinga_agent
# - librenms_agent(snmp)
#
class basesys::monitoring {
  if($basesys::monitoring_enabled){
    include ::monitoring::icinga2_agent
    include ::monitoring::librenms_agent
    #include ::monitoring::collectd
  }
  else {
    include ::monitoring::librenms_agent
    include ::monitoring::collectd
  }
}
