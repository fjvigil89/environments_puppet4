# Class: serv_logrotate
# ===========================
#
# Full description of class serv_logrotate here.
# @rotate_every
# Valid values are 'hour', 'day', 'week', 'month' and 'year'
class serv_logrotate (
  Boolean $compress                = $::serv_logrotate::params::compress,
  Array[Integer] $filelog_numbers  = $::serv_logrotate::params::filelog_numbers,
  Array[String] $rotate_frecuency  = $::serv_logrotate::params::rotate_frecuency,
  Array[String] $rule_list         = $::serv_logrotate::params::rule_list,
  Array[String] $log_path          = $::serv_logrotate::params::log_path,
  Array[String] $postrotate        = $::serv_logrotate::params::postrotate,
  Array[String] $prerotate         = $::serv_logrotate::params::prerotate,


) inherits serv_logrotate::params {
class { '::logrotate':
  ensure => 'latest',
  config => {
    dateext      => true,
    compress     => true,
    rotate       => 5,
    rotate_every => 'week',
    ifempty      => true,
  }
}
 class {'::serv_logrotate::rules':;}
}
