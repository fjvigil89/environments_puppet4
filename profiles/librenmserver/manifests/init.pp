# Class: librenmserver
# ===========================
#
class librenmserver 
(
  String $php_timezone = 'America/Havana', 
)
{
  class { '::apache2::monit':
    monitor_email => 'henry.fleitas@upr.edu.cu',
  }
}
