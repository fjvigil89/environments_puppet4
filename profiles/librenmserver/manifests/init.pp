# Class: librenmserver
# ===========================
#
class librenmserver
(
  String $php_timezone = 'America/Havana',
)
class { '::librenms':
  php_timezone => $php_timezone,

class { '::apache2::monit':
  monitor_email => 'henry.fleitas@upr.edu.cu',
  }
}
