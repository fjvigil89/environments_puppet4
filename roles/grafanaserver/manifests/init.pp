# == Class: grafanaserver
#
# Full description of class grafanaserver here.
#
# === Parameters
#
class grafanaserver {
  class { '::basesys':
    uprinfo_usage  => 'servidor grafana',
    application    => 'Grafana Server',
    puppet_enabled =>   false,
    repos_enabled  => true,
  }
  #include grafana_server

}
