# Class: filebeatserver
# ===========================
# Full description of class filebeatserver here.
#
class filebeatserver(
  Optional[String] $type              = $::filebeatserver::params::type,
  Optional[String] $paths             = $::filebeatserver::params::paths,
  Optional[String] $log_type          = $::filebeatserver::params::log_type,
  Optional[String] $kibana_host       = $::filebeatserver::params::kibana_host,
  Optional[String] $kibana_username   = $::filebeatserver::params::kibana_username,
  Optional[String] $kibana_password   = $::filebeatserver::params::kibana_password,
  Optional[String] $logstash_host     = $::filebeatserver::params::logstash_host,
  Optional[Array[String]] $modules     = $::filebeatserver::params::modules,
 
) inherits ::filebeatserver::params  {
  class {'::filebeatserver::install':;}
  ~>class {'::filebeatserver::service':;}


}
