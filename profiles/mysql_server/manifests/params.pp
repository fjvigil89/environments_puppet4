# Class: mysql_server::params
# ===========================
class mysql_server::params {

  $percona_toolkit_package = 'percona-toolkit'

  $orchestrator_topology_user = 'orchestrator'
  $orchestrator_topology_pass = ''
  $orchestrator_topology_privileges = []
  $orchestrator_hostnames = []

  $mysql_replication_user = 'replication'
  $mysql_replication_pass = ''
  $mysql_replication_hosts = []
  $mysql_replication_delay = 0

  $proxy_servers = []

  $mysql_monitor_username = 'monitor'
  $mysql_monitor_password = 'monitor'

  $mysql_collectd_username = 'collectd'
  $mysql_collectd_password = 'collectd'

  $backend_users = {}
  $mysql_grants = {}
}
