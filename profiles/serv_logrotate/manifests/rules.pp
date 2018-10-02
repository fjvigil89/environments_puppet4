# Class: serv_logrotate::rules
# ===========================
#
# Full description of class serv_logrotate::rules here.
#
class serv_logrotate::rules {
  #   $rule_list        = []
  #$log_path         = []
  # each($::dhcpserver::pool) |Integer $index, String $value|{
  each($::serv_logrotate::rule_list) |Integer $index, String $value| {
    logrotate::rule { $::serv_logrotate::rule_list[$index]:
      path         => $::serv_logrotate::log_path[$index],
      rotate       => $::serv_logrotate::filelog_numbers[$index],
      rotate_every => 'week',
    }
  }
}
