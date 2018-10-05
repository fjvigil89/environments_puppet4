# Class: serv_logrotate::rules
# ===========================
#
# Full description of class serv_logrotate::rules here.
#
class serv_logrotate::rules {
  each($::serv_logrotate::rule_list) |Integer $index, String $value| {
    logrotate::rule { $::serv_logrotate::rule_list[$index]:
      path         => $::serv_logrotate::log_path[$index],
      rotate       => $::serv_logrotate::filelog_numbers[$index].scanf("%i"),
      rotate_every => $::serv_logrotate::rotate_frecuency[$index],
    }
  }
}
