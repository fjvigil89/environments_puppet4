# == Define: metricbeatserver::module
#
define metricbeatserver::module (
  String $module           = 'system',
) {



  #$param_module = $metricbeatserver::params::modules

  exec{"module_$module":
      command => "/usr/bin/sudo metricbeat modules enable $module",
   }

}
