# Class: serv_logrotate
# ===========================
#
# Full description of class serv_logrotate here.
# @rotate_every
# Valid values are 'hour', 'day', 'week', 'month' and 'year'
class serv_logrotate (
  Boolean compress                = $::serv_logrotate::params::compress,
  Integer filelog_numbers         = $::serv_logrotate::params::filelog_numbers,
  Array[Integer] rotate_frecuency = $::serv_logrotate::params::rotate_frecuency,
  Array[String] rule_list         = $::serv_logrotate::params::rule_list,
  Array[String] log_path          = $::serv_logrotate::params::log_path,

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
