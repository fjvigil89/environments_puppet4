# Class: filebeatserver
# ===========================
# Full description of class filebeatserver here.
#
class filebeatserver(
  #Hash $outputs        = $::filebeatserver::params::outputs,
) inherits ::filebeatserver::params  {
  class {'::filebeatserver::install':;}
  class {'::filebeatserver::service':;}


}
